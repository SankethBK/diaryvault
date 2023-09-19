## Diary Vault

#### A FOSS, offline first personal diary application written in Flutter


<a href="https://play.google.com/store/apps/details?id=me.sankethbk.dairyapp">
  <img alt="Android app on Google Play" src="https://developer.android.com/images/brand/en_app_rgb_wo_45.png" />
</a>


## Key Features

1. Rich text editor with support for images and videos
2. Your data is securely preserved on your Google Drive account, ensuring your complete ownership and privacy.
3. Sync data between multiple devices.
4. Fingerprint login on supported devices.
5. Multiple Themes

## Libraries used

1. [Flutter bloc](https://bloclibrary.dev/#/) for state management
2. [Flutter Quill](https://pub.dev/packages/flutter_quill) for rich text editor
3. [Flutter Local Auth Invisible](https://pub.dev/packages/flutter_local_auth_invisible) for fingerprint login
4. [Dartz](https://pub.dev/packages/dartz) for functional programming
5. [SQFLite](https://pub.dev/packages/sqflite): As local database

### Screenshots

<div style="display:flex; flex-wrap: wrap;">
<img src="https://github.com/SankethBK/diaryvault/assets/51091231/9bfe5700-5cf7-4852-a158-f5b19278cc8d" style = "padding: 1rem; height: 300px">
<img src="https://github.com/SankethBK/diaryvault/assets/51091231/5e034a32-3fb9-478b-a3be-61b270f975a9" style = "padding: 1rem;  height: 300px">
<img src="https://github.com/SankethBK/diaryvault/assets/51091231/f7aca438-a923-4977-8cf2-216561aebcc7" style = "padding: 1rem;  height: 300px">
<img src="https://github.com/SankethBK/diaryvault/assets/51091231/d5b5766a-547b-41e9-b834-9035fd805c9f" style = "padding: 1rem;  height: 300px">
<img src="https://github.com/SankethBK/diaryvault/assets/51091231/1ef02504-7b22-4a36-88cd-7381ccc6c847" style = "padding: 1rem;  height: 300px">
<img src="https://github.com/SankethBK/diaryvault/assets/51091231/5928736b-2a2c-44cc-ae6b-2fb311ec796e" style = "padding: 1rem;  height: 300px">
<img src="https://github.com/SankethBK/diaryvault/assets/51091231/e9e59b4e-f318-478c-852f-6ed8a107eb31" style = "padding: 1rem;  height: 300px">
<img src="https://github.com/SankethBK/diaryvault/assets/51091231/89163acc-8905-408a-a652-d3c2d1f8eb06" style = "padding: 1rem;  height: 300px">
</div>

### Motivation for building this app

As someone who enjoys writing in a diary, I've tried out many diary apps on Google Play. Through my own experiences and by reading what others have shared in their reviews, I've gained a better understanding of the issues that current diary apps face.

* Requires premium subscription for seemingly simple features. 
* Lack of proper authentication: In some cases, users have to enter their password every time they log in, as there is no support for fingerprint authentication.
* Ads are the last thing you want to encounter while writing; just picture yourself composing a thought-provoking entry, and an ad suddenly appears, disrupting your train of thought.
* No support for images.
* No automatic save: people don't want to lose their lengthy notes just because they ran out of battery, received a phone call, or clicked on a notification, risking data loss upon their return.
* No Font customization for overall app and individual note level
* No customizable sorting: Not everyone wants to sort by date.

### Feature Roadmap Table

| Feature | Timeline | Issue |
|---------|----------|-------|
| 1. Support for tags | Planned for October release | [#19](https://github.com/SankethBK/diaryvault/issues/19)
| 2. Support for customizable sort order | Planned for October release | [#28](https://github.com/SankethBK/diaryvault/issues/28)
| 3. Auto save for every "x" seconds | Planned for October release | [#29](https://github.com/SankethBK/diaryvault/issues/29)
| 4. Export data to text file | Planned for October release | [#26](https://github.com/SankethBK/diaryvault/issues/26)
| 5. Support for daily reminders | Planned for October release | [#24](https://github.com/SankethBK/diaryvault/issues/24)
| 6. Support for customizable fonts | Planned for November release | [#31](https://github.com/SankethBK/diaryvault/issues/31)
| 7. Support for folder organization | Planned for November release | [#30](https://github.com/SankethBK/diaryvault/issues/30)
| 8. Export data to PDF | Planned for November release | [#25](https://github.com/SankethBK/diaryvault/issues/25)
| 9. Introduce "todos" within rich text editor | Planned for December release | [#20](https://github.com/SankethBK/diaryvault/issues/20)
| 10. Add support for embedding audio files in rich text editor | Planned for December release | [#21](https://github.com/SankethBK/diaryvault/issues/21)

Join our discord server for any hel



### Documentation

The entire project is structured in [this way](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)

<img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1">

For full documentation, check [docs](docs.md)

### Support

If you have any questions or doubts, join our discord server https://discord.gg/S4QkJbV9Vw

### Contributions

For local setup and contribution guidelines, please visit [CONTRIBUTING.md](CONTRIBUTING.md)
