# DiaryVault Translation Environment

Automated translation system using MyMemory API to generate all missing translations from `intl_en.arb`.

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
python translate_all.py --languages fr de es ar
```

### Check What's Missing (Dry Run)
```bash
python translate_all.py --dry-run
```

## Features

- ✅ Uses free MyMemory API (1000 requests/day, no signup)
- ✅ Rate limited to be respectful to free service
- ✅ Supports all 21 languages in your app
- ✅ Preserves existing translations (only adds missing ones)
- ✅ Handles metadata keys correctly

## Language Support

The script will automatically translate to:
- Arabic (ar), Bengali (bn), German (de), Spanish (es)
- Finnish (fi), French (fr), Gujarati (gu), Hebrew (he)
- Hindi (hi), Indonesian (id), Kannada (kn), Nepali (ne)
- Punjabi (pa), Polish (pl), Portuguese (pt), Russian (ru)
- Slovak (sk), Swahili (sw), Telugu (te), Turkish (tr)
- Chinese (zh)

## Output

The script will:
1. Analyze missing keys in each language file
2. Translate missing keys using MyMemory API
3. Update language files with new translations
4. Create backups of original files

After completion, run `flutter gen-l10n` to regenerate Flutter localization files.
