// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sw locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sw';

  static String m0(imported, skipped, failed) =>
      "Maelezo ${imported} yaliyoingizwa, ${skipped} yaliyopo, ${failed} hayajafaulu";

  static String m1(imported, skipped) =>
      "Vidokezo ${imported} vilivyoingizwa, vimerukwa ${skipped} vidokezo vilivyopo";

  static String m2(count) => "Maelezo ${count} yaliyoingizwa";

  static String m3(time) => "Utaarifiwa saa ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Lafudhi"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Kuanzisha akaunti kumefanikiwa",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Tayari una akaunti?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Gundua diaryVault - programu ya kumbukumbu iliyoundwa kukusaidia kukamata mawazo, kumbukumbu, na nyakati yako kwa urahisi. Sasa inapatikana kwenye Duka la Kucheza!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("Lugha ya Programu"),
    "appVersion": MessageLookupByLibrary.simpleMessage("Toleo la Programu"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "Una uhakika wa kutoka?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage("Sawazisha moja kwa moja"),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Huhifadhi madokezo yako kiotomatiki baada ya kila sekunde 10",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Kusawazisha kumbukumbu kiotomatiki na wingu",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Jukwaa zinazopatikana kwa kusawazisha",
    ),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "Kwa kuendelea, unakubaliana na",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Kamera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Ghairi"),
    "change": MessageLookupByLibrary.simpleMessage("Badilisha"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Badilisha rangi ya mandharinyuma",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage("Badilisha Barua pepe"),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Badilisha nenosiri la usimbaji fiche",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Badilisha Picha "),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Badilisha Nenosiri",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Chagua picha ya mandharinyuma",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Chagua Chanzo cha Kusawazisha",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Chagua Maudhui"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Chagua Saa"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("Funga Programu?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage(
      "Hifadhi rudufu ya Wingu",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Thibitisha Nenosiri Jipya",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Thibitisha PIN yako mpya",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Endelea kama mgeni",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Unda"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("Unda mada yako"),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Chagua picha unayopenda au uchague rangi ya mandharinyuma na tutaijenga mandhari.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("Mada mahususi"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage(
      "Vikumbusho vya Kila Siku",
    ),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Giza"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Mada nyeusi"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Chuja tarehe"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Mada Yangu"),
    "delete": MessageLookupByLibrary.simpleMessage("Futa"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage(
      "Kufuta kushindikana",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Imekamilika"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("Huna akaunti?"),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Hariri mandhari"),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Barua pepe imeboreshwa kwa mafanikio, tafadhali ingia tena",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage(
      "Wezesha kuhifadhi kiotomatiki",
    ),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Wezesha Vikumbusho vya Kila Siku",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Wezesha kuingia kwa alama za vidole",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Wezesha usimbaji fiche wa maelezo",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "Wezesha kuingia kwenye PIN",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Ficha maelezo nyeti yenye fungu la maneno tu unalojua. Vidokezo vilivyosimbwa vinalindwa kwenye kifaa hiki na kwenye hifadhidata yako ya wingu na vinaishi katika mwonekano tofauti uliofungwa.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage(
      "Ficha kidokezo hiki",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Maelezo yaliyosimbwa",
    ),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Vidokezo vilivyosimbwa vimefungwa",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("usimbaji fiche"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Imewezeshwa"),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Weka msimbo wa pasipoti na kurejesha",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Ingiza nenosiri la sasa",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage(
      "Ingiza barua pepe mpya",
    ),
    "enterPin": MessageLookupByLibrary.simpleMessage("Weka PIN YAKO"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Ingiza Barua pepe iliyosajiliwa",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Hamisha maelezo yako"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("Hamisha kwenda JSON"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage("Hamisha kwenda PDF"),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Hamisha kwa Maandishi Rahisi",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage(
      "Kushindwa kupata kumbukumbu",
    ),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage(
      "Kushindwa kuhifadhi kumbukumbu",
    ),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "Uthibitisho wa alama za vidole unapaswa kuwezeshwa katika mipangilio ya kifaa",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Kuingia kwa alama za vidole kushindikana",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Familia ya Fonti"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Umesahau Nenosiri"),
    "from": MessageLookupByLibrary.simpleMessage("Kutoka"),
    "gallery": MessageLookupByLibrary.simpleMessage("Galeria"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Pata vikumbusho vya kila siku kwa wakati uliochaguliwa ili uendelee kusasisha jarida lako.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Hamisha na Hamisha Vidokezo",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage(
      "Ingiza kutoka JSON",
    ),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Nenosiri lisilo sahihi",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Nenosiri sio sahihi",
    ),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Msimbo wa uokoaji usio sahihi",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Faili mbadala si sahihi",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Swahili"),
    "lastSynced": MessageLookupByLibrary.simpleMessage(
      "Iliyosawazishwa mwisho: ",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("Ondoka"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Mwanga"),
    "link": MessageLookupByLibrary.simpleMessage("Kiungo"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Funga vidokezo vilivyosimbwa",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("Funga kidokezo hiki"),
    "logIn": MessageLookupByLibrary.simpleMessage("Ingia"),
    "logOut": MessageLookupByLibrary.simpleMessage("Toka"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Jiondoe"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Tafadhali ingia kuanzisha kusawazisha moja kwa moja",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("Taarifa Zaidi"),
    "muted": MessageLookupByLibrary.simpleMessage("Imetiwa doa"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nenosiri Jipya"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Bado hakuna maelezo yaliyosimbwa",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Haipatikani"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Kumbukumbu imehifadhiwa kwa mafanikio",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Kumbukumbu imeboreshwa kwa mafanikio",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Usawazishaji wa kumbukumbu kwa mafanikio",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Tumia dakika chache kutafakari siku yako katika shajara yako",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Hujachagua wakati wa arifa",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "Ni Wakati wa Kuandika Jarida!",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Arifa hazijawezeshwa",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage(
      "Ukurasa haujapatikana",
    ),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Palette (bofya saa ili kuhariri)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Nenosiri"),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "Barua pepe ya kuweka upya nenosiri imepelekwa",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Kuweka upya nenosiri kumefanikiwa",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Nenosiri limethibitishwa",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Nenosiri hazilingani",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Chagua rangi"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Chagua rangi ya mandharinyuma badala yake",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage(
      "Chagua Kutoka kwenye Faili",
    ),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Majaribio ya kuingia hayajafanikiwa",
    ),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "PINI ya tarakimu 4 itaelekezwa kwenye skrini ya kufuli",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Tafadhali weka PIN yenye tarakimu 4",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Hisia ya uthibitisho wa PIN",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage("PIN hazilingani"),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage(
          "Tafadhali weka akaunti yako kutumia kipengee hiki",
        ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Sera ya Faragha"),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage(
      "Mradi kwenye Github",
    ),
    "recordAudio": MessageLookupByLibrary.simpleMessage("Rekodi Sauti"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage("Msimbo wa kurejesha"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Tengeneza upya msimbo wa kurejesha",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Vikumbusho:"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Ondoa usimbaji fiche kutoka kwenye kidokezo hiki",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Weka upya nenosiri"),
    "resetPin": MessageLookupByLibrary.simpleMessage("Weka upya PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage(
      "Hifadhi na utumie mada",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Hifadhi mabadiliko"),
    "security": MessageLookupByLibrary.simpleMessage("Ulinzi"),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "mipangilio ya usalama",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Chagua"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Chagua Sauti"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Tuma maoni"),
    "settings": MessageLookupByLibrary.simpleMessage("Mipangilio"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage(
      "Sanidi Akaunti yako",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Shiriki na Marafiki",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Ingia"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "Ingia kwa kutumia Barua pepe",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Jisajili"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Kusainiwa kama"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage(
      "Panga kulingana na A-Z",
    ),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "Panga kulingana na Mwisho Kwanza",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "Panga kulingana na Wazee Kwanza",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("Baki"),
    "submit": MessageLookupByLibrary.simpleMessage("Tuma"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Sawazisha sasa"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage("tayari ipo"),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Gusa hapa kufungua kichwa",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Binafsisha Mandhari, Fonti na Lugha",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Jina la mada"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Mada Yangu"),
    "to": MessageLookupByLibrary.simpleMessage("Hadi"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Jaribio nyingi za makosa, tafadhali ingia kwa nenosiri",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Nafasi ya upau wa zana",
    ),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Hitilafu isiyotarajiwa ilitokea",
    ),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Fungua vidokezo vilivyosimbwa",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Fungua kidokezo hiki",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("URL ya WebDAV"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Kuna nini kipya?"),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Linda maelezo nyeti kwa kutumia usimbaji fiche unaotegemea maneno ya siri na machaguo ya kurejesha.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Kuhusu usimbaji fiche",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Binafsisha DiaryVault na rangi zako mwenyewe na mtindo wa kuona.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Kuunda na kufanya mada ziwe mahususi",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("PIN isiyo sahihi"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Una mabadiliko ambayo hayajahifadhiwa",
    ),
    "youWillBeNotifiedAt": m3,
  };
}
