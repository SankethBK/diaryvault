#!/usr/bin/env python3
"""
DiaryVault Complete Translation Generator
Uses MyMemory API to translate all missing keys from intl_en.arb reference.
"""

import json
import re
import requests
import time
import os
from pathlib import Path
from typing import Dict, Set, List, Optional
import argparse

class QuotaExceededError(Exception):
    """MyMemory daily quota exhausted or rate-limited; abort the run."""
    pass

# Keys whose English value is a brand/proper noun that should stay
# identical in every language. Copied verbatim, never sent to the API.
BRAND_KEYS = {"nextCloud", "dropbox", "googleDrive", "webdavURL"}

# Languages whose native script is not Latin-based. Latin-1-supplement
# characters (U+0080-U+00FF) in these files indicate mojibake from
# MyMemory's crowdsourced translation memory.
NON_LATIN_LANGS = {"kn", "hi", "bn", "gu", "ne", "pa", "ru", "ur", "zh",
                   "ko", "te", "ps", "he", "ar"}

# MyMemory sometimes appends TM metadata junk like "@ action: inmenu Tools"
_TM_JUNK = re.compile(r"@\s*(action|inmenu|label|menu|info)\b", re.IGNORECASE)


def looks_like_junk(text: str, target_lang: str) -> bool:
    """Reject translation-memory artifacts and mojibake from MyMemory."""
    if _TM_JUNK.search(text):
        return True
    if target_lang in NON_LATIN_LANGS and any(
            0x80 <= ord(c) <= 0xFF for c in text):
        return True
    return False

class DiaryVaultTranslator:
    def __init__(self, l10n_dir: str = "../lib/l10n", email: Optional[str] = None):
        self.l10n_dir = Path(l10n_dir)
        self.english_file = self.l10n_dir / "intl_en.arb"
        self.email = email
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'
        })
        
        # Discover languages dynamically from files like intl_<code>.arb
        self.language_map = self.discover_languages()
        if not self.language_map:
            print("Warning: No language files discovered. Ensure ARB files exist in lib/l10n.")
    
    def discover_languages(self) -> Dict[str, str]:
        """Scan l10n directory for intl_*.arb files and build a language map dynamically."""
        mapping: Dict[str, str] = {}
        if not self.l10n_dir.exists():
            return mapping
        for f in self.l10n_dir.glob("intl_*.arb"):
            name = f.stem  # e.g., intl_en
            if not name.startswith("intl_"):
                continue
            code = name[len("intl_"):]
            # Skip the English reference for target list, but keep file for reference
            if code == "en":
                continue
            # Map code to itself for MyMemory default; special cases can be added here if needed
            mapping[code] = code
        # Also include languages that don't have a file yet (optional). We keep it to discovered ones only.
        return mapping
    
    def load_arb_file(self, file_path: Path) -> Dict:
        """Load and parse an ARB file."""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except FileNotFoundError:
            print(f"Warning: File not found: {file_path}")
            return {}
        except json.JSONDecodeError as e:
            print(f"Error parsing JSON in {file_path}: {e}")
            return {}
    
    def save_arb_file(self, file_path: Path, data: Dict) -> bool:
        """Save data to an ARB file with proper formatting."""
        try:
            with open(file_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
            return True
        except Exception as e:
            print(f"Error saving {file_path}: {e}")
            return False
    
    def translate_text(self, text: str, target_lang: str, source_lang: str = "en") -> Optional[str]:
        """Translate text using MyMemory API.

        Returns None on any failure. NEVER returns the untranslated source:
        writing English into a target file marks the key as "done" and it
        would never be retried.
        """
        if not text or len(text) > 500:
            return None

        params = {
            'q': text,
            'langpair': f"{source_lang}|{target_lang}"
        }
        # Associating an email raises the daily quota
        if self.email:
            params['de'] = self.email

        try:
            response = self.session.get(
                "https://api.mymemory.translated.net/get", params=params, timeout=15)

            if response.status_code == 429:
                raise QuotaExceededError(
                    "MyMemory rate limit hit (HTTP 429). Try again later or pass --email.")

            if response.status_code != 200:
                print(f"    HTTP {response.status_code} for '{text[:50]}'")
                return None

            data = response.json()
            if data.get('quotaFinished'):
                raise QuotaExceededError(
                    "MyMemory daily quota finished. Try again tomorrow or pass --email.")

            if data.get('responseStatus') == 200:
                translated = data['responseData']['translatedText']
                # MyMemory echoes the source back when it has no translation.
                # Reject that only for multi-word phrases - single words are
                # often legitimately identical (cognates: "Video", "Passphrase")
                if translated.strip() == text.strip() and ' ' in text.strip():
                    return None
                # Reject TM artifacts ("@ action: ..." suffixes) and mojibake
                if looks_like_junk(translated, target_lang):
                    print(f"    ⚠️  Rejected junk translation: '{translated[:60]}'")
                    return None
                return translated

            details = data.get('responseDetails', '')
            print(f"    API error for '{text[:50]}': {data.get('responseStatus')} {details}")
            if 'QUOTA' in str(details).upper() or 'LIMIT' in str(details).upper():
                raise QuotaExceededError(str(details))
            return None
        except QuotaExceededError:
            raise
        except Exception as e:
            print(f"    Translation failed for '{text[:50]}...': {e}")
            return None
    
    def get_translation_keys(self, data: Dict) -> Set[str]:
        """Extract translation keys (excluding metadata keys starting with @)."""
        return {key for key in data.keys() if not key.startswith('@')}
    
    def analyze_missing_keys(self) -> Dict[str, Set[str]]:
        """Analyze what keys are missing for each language."""
        if not self.english_file.exists():
            print(f"Error: English reference file not found: {self.english_file}")
            return {}
        
        english_data = self.load_arb_file(self.english_file)
        english_keys = self.get_translation_keys(english_data)
        
        missing_by_lang = {}
        
        for lang_code in self.language_map.keys():
            lang_file = self.l10n_dir / f"intl_{lang_code}.arb"
            if lang_file.exists():
                lang_data = self.load_arb_file(lang_file)
                lang_keys = self.get_translation_keys(lang_data)
                missing_keys = english_keys - lang_keys
                if missing_keys:
                    missing_by_lang[lang_code] = missing_keys
            else:
                # File doesn't exist, all keys are missing
                missing_by_lang[lang_code] = english_keys
        
        return missing_by_lang
    
    def translate_missing_keys(self, lang_code: str, missing_keys: Set[str]) -> Dict[str, str]:
        """Translate missing keys for a specific language."""
        english_data = self.load_arb_file(self.english_file)
        target_lang = self.language_map.get(lang_code, lang_code)
        
        translations = {}
        total = len(missing_keys)
        
        print(f"  Translating {total} keys to {lang_code.upper()}...")
        
        for i, key in enumerate(sorted(missing_keys), 1):
            if key in english_data:
                english_text = english_data[key]

                # Brand names stay as-is in every language
                if key in BRAND_KEYS:
                    translations[key] = english_text
                    continue

                print(f"    [{i}/{total}] {key}: '{english_text[:50]}...'")

                translated_text = self.translate_text(english_text, target_lang)
                if translated_text is None:
                    # Leave the key missing so a future run retries it;
                    # writing English here would mask it forever
                    print(f"    ⚠️  Skipped {key} (no translation obtained)")
                    continue
                translations[key] = translated_text
                
                # Copy metadata if it exists
                meta_key = f"@{key}"
                if meta_key in english_data:
                    translations[meta_key] = english_data[meta_key]
                
                # Rate limiting - be nice to free API
                time.sleep(0.5)
        
        return translations
    
    def update_language_file(self, lang_code: str, new_translations: Dict[str, str]) -> bool:
        """Update or create a language file with new translations."""
        lang_file = self.l10n_dir / f"intl_{lang_code}.arb"
        
        # Load existing data or create new
        if lang_file.exists():
            existing_data = self.load_arb_file(lang_file)
        else:
            existing_data = {}
            # Add language metadata
            language_names = {
                'ar': 'العربية', 'bn': 'বাংলা', 'de': 'Deutsch', 'es': 'Español',
                'fi': 'Suomi', 'fr': 'Français', 'gu': 'ગુજરાતી', 'he': 'עברית',
                'hi': 'हिन्दी', 'id': 'Bahasa Indonesia', 'ja': '日本語', 'ko': '한국어',
                'kn': 'ಕನ್ನಡ', 'ne': 'नेपाली', 'pa': 'ਪੰਜਾਬੀ', 'pl': 'Polski', 'pt': 'Português',
                'ru': 'Русский', 'sk': 'Slovenčina', 'sw': 'Kiswahili', 'te': 'తెలుగు',
                'tr': 'Türkçe', 'zh': '中文'
            }
            existing_data['language'] = language_names.get(lang_code, lang_code.upper())
            existing_data['@language'] = {"description": "The current Language"}
        
        # Merge new translations
        merged_data = existing_data.copy()
        merged_count = 0
        
        for key, value in new_translations.items():
            if key not in merged_data:
                merged_data[key] = value
                merged_count += 1
        
        # Save updated file
        if self.save_arb_file(lang_file, merged_data):
            print(f"  ✅ Added {merged_count} translations to {lang_file.name}")
            return True
        return False
    
    def generate_all_translations(self, languages: List[str] = None) -> None:
        """Generate all missing translations for specified languages."""
        print("🌍 DiaryVault Translation Generator")
        print("=" * 50)
        
        # Refresh discovered languages in case new files were added (e.g., ko)
        self.language_map = self.discover_languages()
        if languages:
            # Keep only requested languages that are discovered, but allow new targets not yet discovered
            requested = {lang: lang for lang in languages}
            self.language_map.update(requested)
        
        missing_by_lang = self.analyze_missing_keys()
        
        if not missing_by_lang:
            print("✅ All translations are complete!")
            return
        
        total_languages = len(missing_by_lang)
        total_keys = sum(len(keys) for keys in missing_by_lang.values())
        
        print(f"Found {total_keys} missing translations across {total_languages} languages")
        print("Languages:", ", ".join(sorted(missing_by_lang.keys())))
        print()
        
        for i, (lang_code, missing_keys) in enumerate(missing_by_lang.items(), 1):
            print(f"[{i}/{total_languages}] Processing {lang_code.upper()} ({len(missing_keys)} missing keys)")

            # Translate missing keys
            try:
                new_translations = self.translate_missing_keys(lang_code, missing_keys)
            except QuotaExceededError as e:
                print(f"\n🛑 Aborting: {e}")
                print("Partial progress was saved. Re-run the script later to continue -")
                print("only successfully translated keys were written.")
                return

            # Update language file
            if new_translations:
                self.update_language_file(lang_code, new_translations)
            
            print()
        
        print("🎉 Translation generation complete!")
        print("\nNext steps:")
        print("1. Review the generated translations")
        print("2. Test the app with new languages")
        print("3. Run: flutter gen-l10n")

def main():
    parser = argparse.ArgumentParser(description="DiaryVault Translation Generator")
    parser.add_argument("--languages", nargs="+", help="Specific languages to translate (e.g., fr de es)")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be translated without doing it")
    parser.add_argument("--email", help="Your email - raises the MyMemory daily quota")

    args = parser.parse_args()

    translator = DiaryVaultTranslator(email=args.email)
    
    if args.dry_run:
        # Refresh discovered languages and report
        translator.language_map = translator.discover_languages()
        missing = translator.analyze_missing_keys()
        print("Missing translations by language:")
        for lang, keys in sorted(missing.items()):
            print(f"  {lang}: {len(keys)} keys")
    else:
        translator.generate_all_translations(args.languages)

if __name__ == "__main__":
    main()
