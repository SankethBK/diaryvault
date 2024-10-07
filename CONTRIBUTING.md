# Contributing to DiaryVault

Thank you for your interest in contributing to DiaryVault! We welcome contributions from the community to help improve and grow this project.

## Setup Guide

DiaryVault is written in Flutter. Even though Flutter is cross-platform, DiaryVault is currently focused on Android. So in order to setup and run the project locally, you need to have an Android emulator or a real device.

DiaryVault currently runs only on **flutter 3.13.0** as some of the packages we are using have breaking changes with later versions of Flutter.

Running the project is as simple as:

```
$ git clone https://github.com/SankethBK/diaryvault

$ flutter pub get

$ flutter run
```

### In case you're installing flutter from the flutter repo, run the following commands to down-grade your version:

1. cd into the path where you cloned flutter to install it into your machine.
2. Fetch all the tags from the flutter repo: 
```
git fetch --tags
```
3. Checkout to the correct flutter version: 
```
git checkout 3.13.0
```
4. Ensure flutter's version updated: 
```
flutter --version
```


If you are contributing for any specific issue, make sure to reference the issue in your PR so that we can help with additional information.

Note: If you face linter issues while submitting PR, run this command `dart format .`
