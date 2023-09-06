## Diaryaholic

#### A personal diary application written in Flutter

<a href="https://play.google.com/store/apps/details?id=me.sankethbk.dairyapp">
  <img alt="Android app on Google Play" src="https://developer.android.com/images/brand/en_app_rgb_wo_45.png" />
</a>

## Key Features

1. Rich text editor with support for images and videos
2. Backup data to your own Google Drive account and sync between multiple devices.
3. Fingerprint login on supported devices.
4. Multiple Themes

## Libraries used

1. [Flutter bloc](https://bloclibrary.dev/#/) for state management
2. [Flutter Quill](https://pub.dev/packages/flutter_quill) for rich text editor
3. [Flutter Local Auth Invisible](https://pub.dev/packages/flutter_local_auth_invisible) for fingerprint login
4. [Dartz](https://pub.dev/packages/dartz) for functional programming
5. [SQFLite](https://pub.dev/packages/sqflite): As local database

### Screenshots

<div style="display:flex; flex-wrap: wrap;">
<img src="https://play-lh.googleusercontent.com/XpmWV-0KYD05TX8wis9_2im9W-dVyoVcelU4Vs65NtOkevLvnQAN4xInIqenQS_E-M_Z=w1052-h592-rw" style = "padding: 1rem; height: 300px">
<img src="https://play-lh.googleusercontent.com/NGA8M9ADN-92a4dqoB8E-I7C9CBx46j30UldKeRiBqqvqBfr4TF6NLNp61NnMqiEz4U=w1052-h592-rw" style = "padding: 1rem;  height: 300px">
<img src="https://play-lh.googleusercontent.com/SeO5qfqjG8K3b9xkp50Q6eCHLFdeq_3kACkkDah2vhMNCpDFIxyje4Br2OpBfzNPZfc=w1052-h592-rw" style = "padding: 1rem;  height: 300px">
<img src="https://play-lh.googleusercontent.com/DFDuTUM6WnVDJkxbBSzuJiZK-BTHuNoIRe8qyvH0n2ReQeSgbqFeGaAL8Zp-N6wVF-FH=w1052-h592-rw" style = "padding: 1rem;  height: 300px">
<img src="https://play-lh.googleusercontent.com/r-op0omSd2BgOLiDHpAsrjG6wKpBCpMzCf3Lf5UBlWOaf98eyoMo_eiH-PTRJ1CDgHh6=w1052-h592-rw" style = "padding: 1rem;  height: 300px">
<img src="https://play-lh.googleusercontent.com/cX3M2PFpQAki-wT2YCZAt8rlUa07H_UAFGpOwePrBfSD-BjgrTMQs_j1FYsgKnSDcbN2=w1052-h592-rw" style = "padding: 1rem;  height: 300px">
<img src="https://play-lh.googleusercontent.com/3JwekFJXpECEN2kczGHRe2-zUneKE0mtutCtThZIYBv9OfGN4vivbYL5KDw5DFhLES4=w1052-h592-rw" style = "padding: 1rem;  height: 300px">
<img src="https://play-lh.googleusercontent.com/0i2Aokmfxw2WaX2aReg3b3bzG3xqMsfOFEXqnguzzHLq3EwnIVxc98biEagpKLiHtc8=w1052-h592-rw" style = "padding: 1rem;  height: 300px">
</div>

### Documentation

The entire project is structured in [this way](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)

<img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1">

(At some places usecase layer is removed as it doesn't carry any logic)

The [features](https://github.com/SankethBK/diaryaholic/tree/master/lib/features) carries a folder  for each of the major features.  

These are the major features as of now

#### 1. Auth

DiaryVault is designed to work fully offline (internet connection is required during signup)



**Signup:** We only support username + password during signup. After a successful signup, data is stored in firebase and then in local SQFlite table named *Users*.  

**Login:** We support *username+password* and *fingerprint* login (if enabled). 
1. When a *username+password* login is attempted first its validated with data stored with *Users* table, if success user is logged in. 
2. If there is password mismatch in local *Users table* firebase login would be attempted (because there is a possibility that password was changed from some other device and local data is stale). If firebase login is successful, data in local *Users* table is updated and user would be logged in.
3. Fingerprint login is disabled by default, it can be enabled in app settings. We store the id of last loggedin user in *shared preferences*. If fingerprint login is attempted and successful, user with *lastLoggedInUserId* would be logged in

Other features like **forgot password**, **reset email**, **reset password** are supported with the help of Firebase. 

#### 2. Sync

The Sync feature plays a pivotal role in ensuring that your diary app seamlessly integrates with Google Drive, allowing users to effortlessly manage their notes across multiple devices. Underpinning this functionality is a streamlined synchronization algorithm, whichminimal version of syncing algorithms used in distributed systems. Here's an in-depth explanation of how it works:

**1. Hash-Based Note Comparison**

Each note within the app is associated with a unique hash value. The hash value is ***SHA1*** hash of note's title + note's body + note's created_at timestamp. This hash serves as a digital fingerprint, allowing us to quickly determine whether a note has been altered.

**2. Initial Cloud Upload and Index File Creation**

* During the initial upload of data to the cloud, an index file is generated and stored in the cloud. This index file, in the form of a CSV (Comma-Separated Values) file, contains vital information such as the note's ID, its hash value, creation timestamp, last modification timestamp, and a flag indicating whether the note has been deleted.
* The app then compares this cloud-based index file with the local Notes table. If any note IDs present in the cloud's index are missing locally, the app initiates a download operation to fetch these missing notes from the cloud.
* Conversely, if a note ID exists locally but not in the cloud, the app uploads it to the cloud.
* When a note ID is found in both the local and cloud indexes, and their respective hash values differ, the app uses the timestamps of the notes' last modifications to determine the appropriate action. If the local version is more recent, it gets uploaded to the cloud; if the cloud version is newer, it gets downloaded to the local device.
* If a note ID exists both locally and in the cloud, and their hash values are identical, no further action is taken, as the notes are already synchronized.

**3. Ensuring Atomic Operations**

All synchronization operations are designed to be atomic. This means that even if a user encounters a sudden loss of internet connectivity during the sync process, it will not result in an unstable or inconsistent state in either the local or cloud storage.

#### 3. Notes

Notes folder has the logic for CRUD operations for notes. FLutter quill is used as rich text editor


### Theming

All of the theme related info can be found in this folder *lib/app/themes*. Currently we have two themes *Coral Bubbles (light theme)* and *Cosmic (dark theme)*.

We are heavily using [Flutter Theme Extensions](https://api.flutter.dev/flutter/material/ThemeExtension-class.html) as the color palette provided by standard ThemeData object is not sufficient. 

Inorder to add a new theme, first step is to chose whether its a light theme or dark theme. Then create a file similar to [lib/app/themes/coral_bubble_theme.dart](https://github.com/SankethBK/diaryaholic/blob/master/lib/app/themes/coral_bubble_theme.dart). Then generate a background image and pick a color palette in accordance to the background image. There are lot of properties used in ThemeData object, but most of them can be copy pasted either from coral_bubbles.dart for light themes and cosmic.dart for dark themes