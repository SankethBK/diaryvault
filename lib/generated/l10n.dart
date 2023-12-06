// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: 'The current Language',
      args: [],
    );
  }

  /// `Page not found`
  String get pageNotFound {
    return Intl.message(
      'Page not found',
      name: 'pageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Enter new email`
  String get enterNewEmail {
    return Intl.message(
      'Enter new email',
      name: 'enterNewEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Registered Email`
  String get enterRegisteredEmail {
    return Intl.message(
      'Enter Registered Email',
      name: 'enterRegisteredEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter current password`
  String get enterCurrentPassword {
    return Intl.message(
      'Enter current password',
      name: 'enterCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Auto sync`
  String get autoSync {
    return Intl.message(
      'Auto sync',
      name: 'autoSync',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sync now`
  String get syncNow {
    return Intl.message(
      'Sync now',
      name: 'syncNow',
      desc: '',
      args: [],
    );
  }

  /// `Available platforms for sync`
  String get availablePlatformsForSync {
    return Intl.message(
      'Available platforms for sync',
      name: 'availablePlatformsForSync',
      desc: '',
      args: [],
    );
  }

  /// `Automatically sync notes with cloud`
  String get automaticallySyncNotesWithCloud {
    return Intl.message(
      'Automatically sync notes with cloud',
      name: 'automaticallySyncNotesWithCloud',
      desc: '',
      args: [],
    );
  }

  /// `Deletion failed`
  String get deletionFailed {
    return Intl.message(
      'Deletion failed',
      name: 'deletionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Enable fingerprint login`
  String get enableFingerPrintLogin {
    return Intl.message(
      'Enable fingerprint login',
      name: 'enableFingerPrintLogin',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint auth should be enabled in device settings`
  String get fingerPrintAthShouldBeEnabledInDeviceSettings {
    return Intl.message(
      'Fingerprint auth should be enabled in device settings',
      name: 'fingerPrintAthShouldBeEnabledInDeviceSettings',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint login failed`
  String get fingerprintLoginFailed {
    return Intl.message(
      'Fingerprint login failed',
      name: 'fingerprintLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Too many wrong attempts, please login with password`
  String get tooManyWrongAttempts {
    return Intl.message(
      'Too many wrong attempts, please login with password',
      name: 'tooManyWrongAttempts',
      desc: '',
      args: [],
    );
  }

  /// `Email updated successfully, please login again`
  String get emailUpdatedSuccessfully {
    return Intl.message(
      'Email updated successfully, please login again',
      name: 'emailUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email sent`
  String get passwordResetMailSent {
    return Intl.message(
      'Password reset email sent',
      name: 'passwordResetMailSent',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get incorrectPassword {
    return Intl.message(
      'Incorrect password',
      name: 'incorrectPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password verified`
  String get passwordVerified {
    return Intl.message(
      'Password verified',
      name: 'passwordVerified',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get passwordsDontMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'passwordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful`
  String get passwordResetSuccessful {
    return Intl.message(
      'Password reset successful',
      name: 'passwordResetSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occured`
  String get unexpectedErrorOccured {
    return Intl.message(
      'Unexpected error occured',
      name: 'unexpectedErrorOccured',
      desc: '',
      args: [],
    );
  }

  /// `Please setup your account to use this feature`
  String get pleaseSetupYourAccountToUseThisFeature {
    return Intl.message(
      'Please setup your account to use this feature',
      name: 'pleaseSetupYourAccountToUseThisFeature',
      desc: '',
      args: [],
    );
  }

  /// `Account setup successful`
  String get accountSetupSuccessful {
    return Intl.message(
      'Account setup successful',
      name: 'accountSetupSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch note`
  String get failedToFetchNote {
    return Intl.message(
      'Failed to fetch note',
      name: 'failedToFetchNote',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save note`
  String get failedToSaveNote {
    return Intl.message(
      'Failed to save note',
      name: 'failedToSaveNote',
      desc: '',
      args: [],
    );
  }

  /// `Note saved successfully`
  String get noteSavedSuccessfully {
    return Intl.message(
      'Note saved successfully',
      name: 'noteSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Note updated successfully`
  String get noteUpdatedSuccessfully {
    return Intl.message(
      'Note updated successfully',
      name: 'noteUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Notes sync successful`
  String get notesSyncSuccessfull {
    return Intl.message(
      'Notes sync successful',
      name: 'notesSyncSuccessfull',
      desc: '',
      args: [],
    );
  }

  /// `Please login to enable auto-sync`
  String get loginToEnableAutoSync {
    return Intl.message(
      'Please login to enable auto-sync',
      name: 'loginToEnableAutoSync',
      desc: '',
      args: [],
    );
  }

  /// `Enable auto save`
  String get enableAutoSave {
    return Intl.message(
      'Enable auto save',
      name: 'enableAutoSave',
      desc: '',
      args: [],
    );
  }

  /// `Date Filter`
  String get dateFilter {
    return Intl.message(
      'Date Filter',
      name: 'dateFilter',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about logging out?`
  String get areYouSureAboutLoggingOut {
    return Intl.message(
      'Are you sure about logging out?',
      name: 'areYouSureAboutLoggingOut',
      desc: '',
      args: [],
    );
  }

  /// `Send feedback`
  String get sendFeedback {
    return Intl.message(
      'Send feedback',
      name: 'sendFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Share with Friends`
  String get shareWithFriends {
    return Intl.message(
      'Share with Friends',
      name: 'shareWithFriends',
      desc: '',
      args: [],
    );
  }

  /// `Choose Theme`
  String get chooseTheme {
    return Intl.message(
      'Choose Theme',
      name: 'chooseTheme',
      desc: '',
      args: [],
    );
  }

  /// `App version`
  String get appVersion {
    return Intl.message(
      'App version',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `Continue as guest`
  String get continueAsGues {
    return Intl.message(
      'Continue as guest',
      name: 'continueAsGues',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to our`
  String get byContinuingYouAgree {
    return Intl.message(
      'By continuing, you agree to our',
      name: 'byContinuingYouAgree',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Close the App?`
  String get closeTheApp {
    return Intl.message(
      'Close the App?',
      name: 'closeTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get changeEmail {
    return Intl.message(
      'Change Email',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Setup your Account`
  String get setupYourAccount {
    return Intl.message(
      'Setup your Account',
      name: 'setupYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgotPassword {
    return Intl.message(
      'Forgot password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Tap here to expand title`
  String get tapToExpandTitle {
    return Intl.message(
      'Tap here to expand title',
      name: 'tapToExpandTitle',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `You have unsaved changes`
  String get youHaveUnsavedChanges {
    return Intl.message(
      'You have unsaved changes',
      name: 'youHaveUnsavedChanges',
      desc: '',
      args: [],
    );
  }

  /// `Dropbox`
  String get dropbox {
    return Intl.message(
      'Dropbox',
      name: 'dropbox',
      desc: '',
      args: [],
    );
  }

  /// `Signed in as`
  String get signedInAs {
    return Intl.message(
      'Signed in as',
      name: 'signedInAs',
      desc: '',
      args: [],
    );
  }

  /// `Last synced: `
  String get lastSynced {
    return Intl.message(
      'Last synced: ',
      name: 'lastSynced',
      desc: '',
      args: [],
    );
  }

  /// `Not available`
  String get notAvailable {
    return Intl.message(
      'Not available',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Google Drive`
  String get googleDrive {
    return Intl.message(
      'Google Drive',
      name: 'googleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Choose the Sync Source`
  String get chooseTheSyncSource {
    return Intl.message(
      'Choose the Sync Source',
      name: 'chooseTheSyncSource',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Discover diaryVault - a diary app designed to help you capture your thoughts, memories, and moments effortlessly. Available now on the Play Store!`
  String get appDescription {
    return Intl.message(
      'Discover diaryVault - a diary app designed to help you capture your thoughts, memories, and moments effortlessly. Available now on the Play Store!',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Notifications are not enabled`
  String get notificationsNotEnabled {
    return Intl.message(
      'Notifications are not enabled',
      name: 'notificationsNotEnabled',
      desc: '',
      args: [],
    );
  }

  /// `You haven't selected a notification time`
  String get notificationTimeNotEnabled {
    return Intl.message(
      'You haven\'t selected a notification time',
      name: 'notificationTimeNotEnabled',
      desc: '',
      args: [],
    );
  }

  /// `You will be notified at {time}`
  String youWillBeNotifiedAt(String time) {
    return Intl.message(
      'You will be notified at $time',
      name: 'youWillBeNotifiedAt',
      desc: '',
      args: [time],
    );
  }

  /// `Enable Daily Reminders`
  String get enableDailyReminders {
    return Intl.message(
      'Enable Daily Reminders',
      name: 'enableDailyReminders',
      desc: '',
      args: [],
    );
  }

  /// `Daily Reminders`
  String get dailyReminders {
    return Intl.message(
      'Daily Reminders',
      name: 'dailyReminders',
      desc: '',
      args: [],
    );
  }

  /// `Get daily reminders at your chosen time to keep your journal up to date.`
  String get getDailyReminders {
    return Intl.message(
      'Get daily reminders at your chosen time to keep your journal up to date.',
      name: 'getDailyReminders',
      desc: '',
      args: [],
    );
  }

  /// `Choose Time`
  String get chooseTime {
    return Intl.message(
      'Choose Time',
      name: 'chooseTime',
      desc: '',
      args: [],
    );
  }

  /// `Time to Journal!`
  String get notificationTitle1 {
    return Intl.message(
      'Time to Journal!',
      name: 'notificationTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Take a few minutes to reflect on your day in your diary`
  String get notificationDescription1 {
    return Intl.message(
      'Take a few minutes to reflect on your day in your diary',
      name: 'notificationDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Sort by Latest First`
  String get sortByLatestFirst {
    return Intl.message(
      'Sort by Latest First',
      name: 'sortByLatestFirst',
      desc: '',
      args: [],
    );
  }

  /// `Sort by Oldest First`
  String get sortByOldestFirst {
    return Intl.message(
      'Sort by Oldest First',
      name: 'sortByOldestFirst',
      desc: '',
      args: [],
    );
  }

  /// `Sort by A-Z`
  String get sortByAtoZ {
    return Intl.message(
      'Sort by A-Z',
      name: 'sortByAtoZ',
      desc: '',
      args: [],
    );
  }

  /// `Export your notes`
  String get exportNotes {
    return Intl.message(
      'Export your notes',
      name: 'exportNotes',
      desc: '',
      args: [],
    );
  }

  /// `Export to Plain Text`
  String get exportToPlainText {
    return Intl.message(
      'Export to Plain Text',
      name: 'exportToPlainText',
      desc: '',
      args: [],
    );
  }

  /// `Export to PDF (beta)`
  String get exportToPDF {
    return Intl.message(
      'Export to PDF (beta)',
      name: 'exportToPDF',
      desc: '',
      args: [],
    );
  }

  /// `Tag already exists`
  String get tagAlreadyExists {
    return Intl.message(
      'Tag already exists',
      name: 'tagAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Security Settings`
  String get securitySettings {
    return Intl.message(
      'Security Settings',
      name: 'securitySettings',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Stay`
  String get stay {
    return Intl.message(
      'Stay',
      name: 'stay',
      desc: '',
      args: [],
    );
  }

  /// `Automatically saves your notes after every 10 seconds`
  String get automaticallySave {
    return Intl.message(
      'Automatically saves your notes after every 10 seconds',
      name: 'automaticallySave',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logOut2 {
    return Intl.message(
      'Logout',
      name: 'logOut2',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get appLanguage {
    return Intl.message(
      'App Language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `NextCloud`
  String get nextCloud {
    return Intl.message(
      'NextCloud',
      name: 'nextCloud',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV URL`
  String get webdavURL {
    return Intl.message(
      'WebDAV URL',
      name: 'webdavURL',
      desc: '',
      args: [],
    );
  }

  /// `More Info`
  String get moreInfo {
    return Intl.message(
      'More Info',
      name: 'moreInfo',
      desc: '',
      args: [],
    );
  }

  /// `Reset PIN`
  String get resetPin {
    return Intl.message(
      'Reset PIN',
      name: 'resetPin',
      desc: '',
      args: [],
    );
  }

  /// `Enter your PIN`
  String get enterPin {
    return Intl.message(
      'Enter your PIN',
      name: 'enterPin',
      desc: '',
      args: [],
    );
  }

  /// `PIN confirmation feeling`
  String get pinResetSuccessful {
    return Intl.message(
      'PIN confirmation feeling',
      name: 'pinResetSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your new PIN`
  String get confirmNewPin {
    return Intl.message(
      'Confirm your new PIN',
      name: 'confirmNewPin',
      desc: '',
      args: [],
    );
  }

  /// `The PINs don't match`
  String get pinsDontMatch {
    return Intl.message(
      'The PINs don\'t match',
      name: 'pinsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Pin login failed`
  String get pinLoginFailed {
    return Intl.message(
      'Pin login failed',
      name: 'pinLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Enable Pin login`
  String get enablePINLogin {
    return Intl.message(
      'Enable Pin login',
      name: 'enablePINLogin',
      desc: '',
      args: [],
    );
  }

  /// `An up 4 to digit PIN will be prompted on lock screen`
  String get pinLoginSetupInstructions {
    return Intl.message(
      'An up to 4 digit PIN will be prompted on lock screen',
      name: 'pinLoginSetupInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Font Family`
  String get fontFamily {
    return Intl.message(
      'Font Family',
      name: 'fontFamily',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'gu'),
      Locale.fromSubtags(languageCode: 'he'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'kn'),
      Locale.fromSubtags(languageCode: 'pa'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'sw'),
      Locale.fromSubtags(languageCode: 'te'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
