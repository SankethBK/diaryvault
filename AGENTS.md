# Project guidance

- Do not hardcode user-facing text. Add strings to `lib/l10n/intl_en.arb` and use the generated localization API.
- Prefer the active theme's colors and text styles wherever possible; avoid hardcoded UI colors and typography.
- Run the app with `make run-staging` (Flutter 3.32 SDK). After editing `lib/l10n/intl_en.arb`, regenerate strings with `flutter pub run intl_utils:generate`.
