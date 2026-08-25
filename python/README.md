# DiaryVault Translation Environment

Automated translation system using the MyMemory API to generate all missing translations from `intl_en.arb`.

## Quick Setup

```bash
cd python
chmod +x setup.sh
./setup.sh
```

## Usage

### Activate Environment
```bash
source venv/bin/activate
```

### Generate All Missing Translations
```bash
python translate_all.py
```

### Generate Specific Languages Only
```bash
python translate_all.py --languages fr de es
```

### Check What's Missing (Dry Run)
```bash
python translate_all.py --dry-run
```

## Features

- ✅ Uses the free MyMemory API (1000 requests/day, no signup required)
- ✅ Rate limited to be respectful to the free service
- ✅ Discovers languages dynamically from `lib/l10n/intl_*.arb` files
- ✅ Preserves existing translations (only adds missing ones)
- ✅ Handles metadata keys correctly
- ✅ Rejects low-quality translation-memory artifacts and mojibake

## Language Support

The script discovers all ARB files automatically. Current supported languages include:

- Arabic (ar), Bengali (bn), German (de), Spanish (es)
- Finnish (fi), French (fr), Gujarati (gu), Hebrew (he)
- Hindi (hi), Indonesian (id), Kannada (kn), Korean (ko)
- Nepali (ne), Pashto (ps), Punjabi (pa), Polish (pl)
- Portuguese (pt), Russian (ru), Slovak (sk), Swahili (sw)
- Telugu (te), Turkish (tr), Urdu (ur), Chinese (zh)

To add a new language, create an empty `lib/l10n/intl_<code>.arb` file and run the script.

## Output

The script will:
1. Analyze missing keys in each language file
2. Translate missing keys using the MyMemory API
3. Update language files with new translations
4. Create backups of original files

After completion, run `flutter gen-l10n` to regenerate Flutter localization files.
