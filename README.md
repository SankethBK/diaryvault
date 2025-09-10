# Diary Vault

**A FOSS, offline first personal diary application written in Flutter**

<div>
  <a href="https://play.google.com/store/apps/details?id=me.sankethbk.dairyapp">
    <img alt="Android App on Google Play" src="https://developer.android.com/images/brand/en_app_rgb_wo_45.png" />
  </a>
</div>

<div>
  <a href="https://apt.izzysoft.de/fdroid/index/apk/me.sankethbk.dairyapp/">
    <img alt="Android App on Google Play" src="https://gitlab.com/IzzyOnDroid/repo/-/raw/master/assets/IzzyOnDroid.png" height="65"/>
  </a>
</div>

We are participating in [Hacktoberfest 2024](https://hacktoberfest.com/)! Contributions are welcome and greatly appreciated.

[![Hacktoberfest](https://img.shields.io/badge/Hacktoberfest-2024-blueviolet?style=flat&logo=hackster&logoColor=white)](https://hacktoberfest.com/)

### Screenshots

<div style="display:flex; flex-wrap: wrap;">
  <img src="readme_assets/screenshot_1.webp" style = "padding: 1rem; height: 300px">
  <img src="readme_assets/screenshot_2.webp" style = "padding: 1rem; height: 300px">
  <img src="readme_assets/screenshot_3.webp" style = "padding: 1rem; height: 300px">
  <img src="readme_assets/screenshot_4.webp" style = "padding: 1rem; height: 300px">
  <img src="readme_assets/screenshot_5.webp" style = "padding: 1rem; height: 300px">
  <img src="readme_assets/screenshot_6.webp" style = "padding: 1rem; height: 300px">
  <img src="readme_assets/screenshot_7.webp" style = "padding: 1rem; height: 300px">
  <img src="readme_assets/screenshot_8.webp" style = "padding: 1rem; height: 300px">
</div>


### Motivation for building this app

As someone who enjoys writing in a diary, I've tried out many diary apps on Google Play.
Through my own experiences and by reading what others have shared in their reviews, I've gained a better understanding of the issues that current diary apps face.

* Requires premium subscription for seemingly simple features
* Lack of proper authentication: In some cases, users have to enter their password every time they log in, as there is no support for fingerprint authentication
* Ads are the last thing you want to encounter while writing; just picture yourself composing a thought-provoking entry, and an ad suddenly appears, disrupting your train of thought
* No support for images
* No automatic saving: People don't want to lose their lengthy notes just because they ran out of battery, received a phone call or clicked on a notification
* No font customization for overall app and individual note level
* No customizable sorting: Not everyone wants to sort by date

🌟 **If you like what we're building, please consider starring our repository on GitHub to show your support. It means a lot to us!** ⭐

## Key Features

1. Rich text editor with support for images, audio and videos
2. Your data is securely preserved on your Google Drive / Dropbox account, ensuring complete ownership and privacy
3. Sync data between multiple devices
4. Notes can be organized by attaching tags
5. Notes can be exported to text files and PDF files
6. Secure your notes with PIN and Fingerprint lock
7. Daily reminder notifications to stay on track with writing
8. Multiple Themes and languages

## 🌍 Translations

DiaryVault supports **22 languages** with automated translation management:

- **Complete Coverage**: Arabic, Bengali, German, Spanish, Finnish, French, Gujarati, Hebrew, Hindi, Indonesian, Kannada, Nepali, Punjabi, Polish, Portuguese, Russian, Slovak, Swahili, Telugu, Turkish, Chinese
- **Automated System**: Missing translations are automatically generated using AI translation services
- **Community Contributions**: Native speakers welcome to review and improve translations

### For Contributors: Adding/Updating Translations

We have an automated translation system that makes contributing translations easy:

```bash
cd python
./setup.sh
source venv/bin/activate
python translate_all.py --dry-run  # Check what's missing
python translate_all.py            # Generate all missing translations
```

For detailed instructions, see [`python/README.md`](python/README.md).

### Features Planned for Future Releases

- Add OneDrive and Nextcloud as cloud backup sources.
- Add support for embedding audio files in the rich text editor.
- Implement a simple to-do list within the rich text editor.
- Organize notes using smart folders.
- Add support for stickers within the editor.



### Support

Join our [Discord server](https://discord.gg/8TTApFpNEA) to streamline the collaboration. We have a small community of contributors. We're here to assist you!

[![Join our Discord Server](https://img.shields.io/badge/Discord-7289DA?logo=discord&logoColor=white)](https://discord.gg/8TTApFpNEA)


### Contributions

For local setup and contribution guidelines, please visit [CONTRIBUTING.md](CONTRIBUTING.md).

### Documentation


Checkout our [wiki pages](https://github.com/SankethBK/diaryvault/wiki/) for documentation.
