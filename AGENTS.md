# Project guidance

- Do not hardcode user-facing text. Add strings to `lib/l10n/intl_en.arb` and use the generated localization API.
- Prefer the active theme's colors and text styles wherever possible; avoid hardcoded UI colors and typography.
- Run the app with `make run-staging` (Flutter 3.32 SDK). After editing `lib/l10n/intl_en.arb`, regenerate strings with `flutter pub run intl_utils:generate`.

## Release workflow

1. **Version bump:** update `version` in `pubspec.yaml` (`versionName+versionCode`), e.g. `2.3.8+2032`.
2. **Merge to `master`:** squash-merge the release branch into `master`.
3. **Tag & GitHub release:**
   - Tag the squashed commit: `git tag -a 2.3.8 -m "Release 2.3.8" <commit>` and push the tag.
   - Create a GitHub release from that tag with notes that include the **exact commit SHA** for reproducible-build verification.
   - Let the existing GitHub Actions workflow build and attach the APKs.
4. **FOSS build:** `foss_master` is intentionally divergent (no proprietary dependencies such as Google Drive). Cherry-pick the squashed release commit onto `foss_master`, dropping the Google Drive and website-specific pieces. Resolve dependency versions in `pubspec.yaml` in favour of `foss_master`'s existing constraints.

## Asset lessons

- The launcher icon pack from `diaryvault_logo_transparent/android` is **transparent and full-bleed**. For Android adaptive icons, regenerate the `ic_launcher_foreground.png` files with the logo scaled down to ~58% of the 108dp canvas so the launcher mask does not clip the drop shadow.
- `flutter_native_splash` does **not** support `.webp`; use `.png` for the source image.
- The splash source image should also be padded/centered so the logo (and its shadow) stays fully visible; 60% of a 512×512 canvas works well.
- The dark purple from the new logo is approximately `#271AA5` and is used for the splash background, welcome page background and launcher adaptive-icon background.
- MaterialApp's `title` property is evaluated before localization is ready. Use `onGenerateTitle: (context) => S.of(context).appTitle` instead of `title: S.current.appTitle`.
