#!/usr/bin/env python3
"""
DiaryVault Complete Translation Generator
Uses MyMemory API to translate all missing keys from intl_en.arb reference.
"""

import json
import requests
import time
import os
from pathlib import Path
from typing import Dict, Set, List
import argparse

class DiaryVaultTranslator:
    def __init__(self, l10n_dir: str = "../lib/l10n"):
        self.l10n_dir = Path(l10n_dir)
        self.english_file = self.l10n_dir / "intl_en.arb"
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
    
    def translate_text(self, text: str, target_lang: str, source_lang: str = "en") -> str:
        """Translate text using MyMemory API."""
        if not text or len(text) > 500:
            return text
        
        try:
            url = "https://api.mymemory.translated.net/get"
            params = {
                'q': text,
                'langpair': f"{source_lang}|{target_lang}"
            }
            
            response = self.session.get(url, params=params, timeout=10)
            if response.status_code == 200:
                data = response.json()
                if data.get('responseStatus') == 200:
                    translated = data['responseData']['translatedText']
                    return translated if translated != text else text
            return text
        except Exception as e:
            print(f"    Translation failed for '{text[:50]}...': {e}")
            return text
    
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
                print(f"    [{i}/{total}] {key}: '{english_text[:50]}...'")
                
                translated_text = self.translate_text(english_text, target_lang)
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
            new_translations = self.translate_missing_keys(lang_code, missing_keys)
            
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
    
    args = parser.parse_args()
    
    translator = DiaryVaultTranslator()
    
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
