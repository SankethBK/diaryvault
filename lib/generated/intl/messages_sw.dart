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

  static String m3(minLength) =>
      "Neno la siri lazima liwe na angalau herufi ${minLength}";

  static String m4(time) => "Utaarifiwa saa ${time}";

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
    "appTitle": MessageLookupByLibrary.simpleMessage("Maziwa Yangu"),
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
    "backAction": MessageLookupByLibrary.simpleMessage("Nyuma"),
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
    "changePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Badilisha nenosiri",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Badilisha Nenosiri",
    ),
    "changeReminderTime": MessageLookupByLibrary.simpleMessage(
      "Badilisha wakati wa kumbusho",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Chagua picha ya mandharinyuma",
    ),
    "choosePassphraseHint": MessageLookupByLibrary.simpleMessage(
      "Utaweka hii ili ufungue maelezo yaliyosimbwa. Tumia kitu kirefu na cha kukumbukwa.",
    ),
    "choosePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Chagua kifungu cha maneno",
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
    "confirmNewPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Thibitisha nenosiri jipya",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Thibitisha Nenosiri Jipya",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Thibitisha PIN yako mpya",
    ),
    "confirmPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Thibitisha nenosiri",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Endelea kama mgeni",
    ),
    "continueButton": MessageLookupByLibrary.simpleMessage("Endelea"),
    "copyButtonTooltip": MessageLookupByLibrary.simpleMessage("Nakili "),
    "create": MessageLookupByLibrary.simpleMessage("Unda"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("Unda mada yako"),
    "currentPassphraseIncorrect": MessageLookupByLibrary.simpleMessage(
      "Nenosiri la sasa si sahihi",
    ),
    "currentPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Fungu la maneno la sasa",
    ),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Chagua picha unayopenda au uchague rangi ya mandharinyuma na tutaijenga mandhari.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("Mada mahususi"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage(
      "Vikumbusho vya Kila Siku",
    ),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Giza"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Mada nyeusi"),
    "dashboardAddTodo": MessageLookupByLibrary.simpleMessage("Ongeza tozo"),
    "dashboardAnotherPrompt": MessageLookupByLibrary.simpleMessage(
      "Kidokezi kingine",
    ),
    "dashboardComingSoon": MessageLookupByLibrary.simpleMessage(
      "Inakuja hivi karibuni",
    ),
    "dashboardCompletedTodos": MessageLookupByLibrary.simpleMessage(
      "Imekamilishwa ",
    ),
    "dashboardCreateTodo": MessageLookupByLibrary.simpleMessage("Ongeza"),
    "dashboardDailyPrompt": MessageLookupByLibrary.simpleMessage(
      "Haraka ya kila siku",
    ),
    "dashboardDailyPrompt1": MessageLookupByLibrary.simpleMessage(
      "Ni nini kilichohisi kama ushindi mdogo kwangu leo?",
    ),
    "dashboardDailyPrompt2": MessageLookupByLibrary.simpleMessage(
      "Ni wakati gani kuanzia leo ninataka kukumbuka?",
    ),
    "dashboardDailyPrompt3": MessageLookupByLibrary.simpleMessage(
      "Ni nini kilichochukua nguvu zaidi kuliko nilivyotarajia leo?",
    ),
    "dashboardDailyPrompt4": MessageLookupByLibrary.simpleMessage(
      "Ninaweza kuacha nini usiku wa leo?",
    ),
    "dashboardDailyPrompt5": MessageLookupByLibrary.simpleMessage(
      "Nilijifunza nini kuhusu mimi mwenyewe leo?",
    ),
    "dashboardDailyPrompt6": MessageLookupByLibrary.simpleMessage(
      "Ni nini kilichorahisisha siku yangu?",
    ),
    "dashboardDailyPrompt7": MessageLookupByLibrary.simpleMessage(
      "Ni nini kitakachofanya kesho nijisikie mpole kwangu?",
    ),
    "dashboardDailyPrompt8": MessageLookupByLibrary.simpleMessage(
      "Ni nini kilichonifanya nihisi shukrani leo?",
    ),
    "dashboardDueToday": MessageLookupByLibrary.simpleMessage(
      "Inahitajika leo",
    ),
    "dashboardEditTodo": MessageLookupByLibrary.simpleMessage("Hariri todo"),
    "dashboardMoodCheckIn": MessageLookupByLibrary.simpleMessage(
      "Kuingia kwa hisia",
    ),
    "dashboardMoodContextPrompt": MessageLookupByLibrary.simpleMessage(
      "Ungependa kuongeza muktadha kidogo?",
    ),
    "dashboardMoodDifficult": MessageLookupByLibrary.simpleMessage(
      "Kuwa na siku ngumu",
    ),
    "dashboardMoodGood": MessageLookupByLibrary.simpleMessage("Nzuri"),
    "dashboardMoodGreat": MessageLookupByLibrary.simpleMessage("Nzuri sana"),
    "dashboardMoodLow": MessageLookupByLibrary.simpleMessage("Sio nzuri."),
    "dashboardMoodNoteTitle": MessageLookupByLibrary.simpleMessage(
      "Tafakari ya leo",
    ),
    "dashboardMoodOkay": MessageLookupByLibrary.simpleMessage("Sawa"),
    "dashboardMoodOpeningDifficult": MessageLookupByLibrary.simpleMessage(
      "Leo imekuwa siku ngumu.",
    ),
    "dashboardMoodOpeningGood": MessageLookupByLibrary.simpleMessage(
      "Leo, ninajisikia vizuri.",
    ),
    "dashboardMoodOpeningGreat": MessageLookupByLibrary.simpleMessage(
      "Leo, ninajisikia vizuri.",
    ),
    "dashboardMoodOpeningLow": MessageLookupByLibrary.simpleMessage(
      "Leo, sijisikii vizuri.",
    ),
    "dashboardMoodOpeningOkay": MessageLookupByLibrary.simpleMessage(
      "Leo, ninajisikia vizuri.",
    ),
    "dashboardMoodReflectionHint": MessageLookupByLibrary.simpleMessage(
      "Je, una jambo jingine lolote akilini mwako? (hiari)",
    ),
    "dashboardMoodSaveToJournal": MessageLookupByLibrary.simpleMessage(
      "Ongeza kwenye dokezo la leo",
    ),
    "dashboardMoodSubtitle": MessageLookupByLibrary.simpleMessage(
      "Unajihisi vipi leo?",
    ),
    "dashboardNoDueDate": MessageLookupByLibrary.simpleMessage(
      "Hakuna tarehe ya mwisho",
    ),
    "dashboardNoTodos": MessageLookupByLibrary.simpleMessage(
      "Hakuna todos hapa bado",
    ),
    "dashboardNoTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Kazi zako zilizo wazi na zilizokamilishwa zitaonekana hapa.",
    ),
    "dashboardOpenInNote": MessageLookupByLibrary.simpleMessage(
      "Fungua kidokezo",
    ),
    "dashboardOpenTodos": MessageLookupByLibrary.simpleMessage("Fungua"),
    "dashboardOverdue": MessageLookupByLibrary.simpleMessage("Kufikia muda"),
    "dashboardPromptSubtitle": MessageLookupByLibrary.simpleMessage(
      "Swali dogo la kutafakari",
    ),
    "dashboardQuickCapture": MessageLookupByLibrary.simpleMessage(
      "Picha ya haraka",
    ),
    "dashboardReminderOptional": MessageLookupByLibrary.simpleMessage(
      "Hakuna kikumbusho kilichowekwa",
    ),
    "dashboardSaveTodo": MessageLookupByLibrary.simpleMessage("Hifadhi"),
    "dashboardToday": MessageLookupByLibrary.simpleMessage(
      "Nasikitika sana kwa kile nilichokifanya",
    ),
    "dashboardTodoLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Haikuweza kupakia todos",
    ),
    "dashboardTodoRequired": MessageLookupByLibrary.simpleMessage(
      "Weka tozo kwanza",
    ),
    "dashboardTodoSourceHint": MessageLookupByLibrary.simpleMessage(
      "Kila kitu kinaweza kuongezwa kutoka kwenye ujumbe au kuundwa moja kwa moja hapa.",
    ),
    "dashboardTodoTitle": MessageLookupByLibrary.simpleMessage(
      "Ni nini kinachohitaji kufanywa?",
    ),
    "dashboardTodoUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Imeshindwa kusasisha todo hii",
    ),
    "dashboardTodos": MessageLookupByLibrary.simpleMessage("Todos"),
    "dashboardUpcoming": MessageLookupByLibrary.simpleMessage("Mbeleni"),
    "dashboardWriteAboutPrompt": MessageLookupByLibrary.simpleMessage(
      "Andika kuhusu hili",
    ),
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
    "editorPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Andika kitu hapa...",
    ),
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
    "encryptYourNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Vidokezo unavyoweka alama kama vilivyosimbwa vinalindwa kwenye kifaa hiki na kwenye nakala rudufu yako ya wingu iliyo na nenosiri unalojua tu. Hakuna mtu mwingine - ikiwa ni pamoja na sisi na mtoa huduma wako wa wingu - anayeweza kuyasoma.",
    ),
    "encryptYourNotesTitle": MessageLookupByLibrary.simpleMessage(
      "Ficha maelezo yako",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Maelezo yaliyosimbwa",
    ),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Vidokezo vilivyosimbwa vimefungwa",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("usimbaji fiche"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Imewezeshwa"),
    "encryptionEnabledToast": MessageLookupByLibrary.simpleMessage(
      "Usimbaji fiche umewezeshwa",
    ),
    "encryptionLossAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Ninaelewa hakuna njia ya kurejesha maelezo yangu ikiwa nitasahau nenosiri hili na kupoteza msimbo wa kurejesha",
    ),
    "encryptionLossWarning": MessageLookupByLibrary.simpleMessage(
      "⚠️ Ukisahau nenosiri lako NA kupoteza msimbo wa kurejesha, maelezo yaliyosimbwa yameondoka milele. Hakuna njia ya kuzirejesha.",
    ),
    "encryptionSeparateViewDescription": MessageLookupByLibrary.simpleMessage(
      "Vidokezo vilivyosimbwa vinaishi katika mwonekano tofauti uliofungwa na havijumuishwi katika utafutaji.",
    ),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Weka msimbo wa pasipoti na kurejesha",
    ),
    "encryptionStaysOnToast": MessageLookupByLibrary.simpleMessage(
      "Usimbaji fiche utawashwa kwa ajili ya maelezo yaliyosimbwa. Zifunge wakati wowote kutoka kwenye mwonekano wa maelezo yaliyosimbwa.",
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
    "forgotPassphraseUseRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Umesahau nenosiri? Tumia msimbo wa kurejesha",
    ),
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
    "lockAction": MessageLookupByLibrary.simpleMessage("Funga"),
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
    "newPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Kifungu kipya cha maneno",
    ),
    "newPassphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Maneno mapya ya siri hayalingani",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nenosiri Jipya"),
    "newRecoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Nimeandika msimbo mpya",
    ),
    "newRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Iandike na uiweke salama. Haitaonyeshwa tena.",
    ),
    "newRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Msimbo mpya wa kurejesha",
    ),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Bado hakuna maelezo yaliyosimbwa",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Haipatikani"),
    "notNow": MessageLookupByLibrary.simpleMessage("Na sasa yeye si"),
    "noteCollapsePreview": MessageLookupByLibrary.simpleMessage("Kunja hakiki"),
    "noteDifferentPassphrase": MessageLookupByLibrary.simpleMessage(
      "Ujumbe huu unalindwa na nenosiri tofauti",
    ),
    "noteExpandPreview": MessageLookupByLibrary.simpleMessage("Panua hakiki"),
    "noteNoTitle": MessageLookupByLibrary.simpleMessage(
      "Ujumbe usio na kichwa",
    ),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Kumbukumbu imehifadhiwa kwa mafanikio",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Kumbukumbu imeboreshwa kwa mafanikio",
    ),
    "noteWillBeSavedEncrypted": MessageLookupByLibrary.simpleMessage(
      "Ujumbe utahifadhiwa kwa njia fiche",
    ),
    "noteWillBeSavedUnencrypted": MessageLookupByLibrary.simpleMessage(
      "Ujumbe utahifadhiwa bila kusimbwa",
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
    "passphraseLabel": MessageLookupByLibrary.simpleMessage("Nenosiri"),
    "passphraseMinLength": m3,
    "passphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Maneno ya siri hayalingani",
    ),
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
    "recoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Nimeandika msimbo wangu wa kurejesha",
    ),
    "recoveryCodeCopiedToast": MessageLookupByLibrary.simpleMessage(
      "Msimbo wa kurejesha umenakiliwa",
    ),
    "recoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Andika hii na uiweke mahali salama. Ni njia PEKEE ya kurejesha maelezo yako ikiwa utasahau kifungu cha maneno. Haitaonyeshwa tena.",
    ),
    "regenerateButton": MessageLookupByLibrary.simpleMessage(
      "Kuipatia nguvu upya",
    ),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Tengeneza upya msimbo wa kurejesha",
    ),
    "regenerateRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Hii inabatilisha msimbo wako wa zamani wa kurejesha. Weka nenosiri lako ili uendelee.",
    ),
    "reminderRemoved": MessageLookupByLibrary.simpleMessage(
      "Kumbusho limeondolewa",
    ),
    "reminderSchedulingFailed": MessageLookupByLibrary.simpleMessage(
      "Haikuweza kuratibu kumbusho. Tafadhali jaribu tena.",
    ),
    "reminderSet": MessageLookupByLibrary.simpleMessage("Seti ya kumbusho"),
    "reminderTimeMustBeInFuture": MessageLookupByLibrary.simpleMessage(
      "Tafadhali chagua wakati ujao",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Vikumbusho:"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Ondoa usimbaji fiche kutoka kwenye kidokezo hiki",
    ),
    "removeReminder": MessageLookupByLibrary.simpleMessage("Ondoa kikumbusho"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Weka upya nenosiri"),
    "resetPin": MessageLookupByLibrary.simpleMessage("Weka upya PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage(
      "Hifadhi na utumie mada",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Hifadhi mabadiliko"),
    "searchInNoteHint": MessageLookupByLibrary.simpleMessage(
      "Tafuta kwa maelezo",
    ),
    "security": MessageLookupByLibrary.simpleMessage("Ulinzi"),
    "securityBackedUpNotes": MessageLookupByLibrary.simpleMessage(
      "Imehifadhiwa",
    ),
    "securityBackupNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Chagua mtoa huduma wa chelezo ya wingu ili kuona takwimu za chelezo.",
    ),
    "securityBackupOffline": MessageLookupByLibrary.simpleMessage(
      "Hali ya hifadhi haipatikani nje ya mtandao.",
    ),
    "securityBackupSetupHint": MessageLookupByLibrary.simpleMessage(
      "Wezesha chelezo ya wingu ili usipoteze vidokezo vyako.",
    ),
    "securityBackupSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Weka chelezo",
    ),
    "securityBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Faragha na chelezo",
    ),
    "securityBackupUnverified": MessageLookupByLibrary.simpleMessage(
      "Sawazisha mara moja ili kuthibitisha hali yako ya chelezo.",
    ),
    "securityEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Maelezo yaliyosimbwa",
    ),
    "securityLastSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Uoanishaji wa mwisho umefanikiwa",
    ),
    "securityLastSync": MessageLookupByLibrary.simpleMessage(
      "Usawazishaji wa mwisho: ",
    ),
    "securityMetricUnavailable": MessageLookupByLibrary.simpleMessage(
      "haipatikani",
    ),
    "securityNoSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Hakuna usawazishaji uliofanikiwa bado.",
    ),
    "securityPendingBackup": MessageLookupByLibrary.simpleMessage(
      "Inahitaji nakala rudufu",
    ),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "mipangilio ya usalama",
    ),
    "securityStatsNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Bado hujachagua tovuti chelezo ya wingu.",
    ),
    "securitySyncedData": MessageLookupByLibrary.simpleMessage("Data ya wingu"),
    "select": MessageLookupByLibrary.simpleMessage("Chagua"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Chagua Sauti"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Tuma maoni"),
    "setPassphrase": MessageLookupByLibrary.simpleMessage("Weka nenosiri"),
    "setTodoReminder": MessageLookupByLibrary.simpleMessage(
      "Weka kikumbusho cha kufanya",
    ),
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
    "syncSourceNone": MessageLookupByLibrary.simpleMessage("Hakuna"),
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
    "todoReminderNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Kumbusho la kufanya",
    ),
    "todoRemindersNeedUncheckedTodo": MessageLookupByLibrary.simpleMessage(
      "Weka mshale kwenye kitu cha kufanya ili kuweka kikumbusho",
    ),
    "todoRemindersUnavailableInEncryptedNotes":
        MessageLookupByLibrary.simpleMessage(
          "Vikumbusho havipatikani katika maelezo yaliyosimbwa",
        ),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Jaribio nyingi za makosa, tafadhali ingia kwa nenosiri",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Nafasi ya upau wa zana",
    ),
    "toolbarPositionBottom": MessageLookupByLibrary.simpleMessage("Chini"),
    "toolbarPositionTop": MessageLookupByLibrary.simpleMessage("Juu"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Hitilafu isiyotarajiwa ilitokea",
    ),
    "unlockAction": MessageLookupByLibrary.simpleMessage("Fungua"),
    "unlockButton": MessageLookupByLibrary.simpleMessage("Fungua"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Fungua vidokezo vilivyosimbwa",
    ),
    "unlockNoteAction": MessageLookupByLibrary.simpleMessage("Fungua kidokezo"),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Fungua kidokezo hiki",
    ),
    "usePassphraseInstead": MessageLookupByLibrary.simpleMessage(
      "Tumia nenosiri badala yake",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "visitWebsite": MessageLookupByLibrary.simpleMessage(
      "TEMBELEA  TOVUTI  YETU",
    ),
    "webdavURL": MessageLookupByLibrary.simpleMessage("URL ya WebDAV"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Kuna nini kipya?"),
    "whatsNewCloudBackupSubtitle": MessageLookupByLibrary.simpleMessage(
      "Angalia ni vidokezo vipi vimehifadhiwa, vinasubiri kupakiwa na ni lini usawazishaji wako wa mwisho ulitokea.",
    ),
    "whatsNewCloudBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Hali ya chelezo ya wingu",
    ),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Linda maelezo nyeti kwa kutumia usimbaji fiche unaotegemea maneno ya siri na machaguo ya kurejesha.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Kuhusu usimbaji fiche",
    ),
    "whatsNewHomeSearchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Pata vidokezo kutoka kwenye ukurasa wa mwanzo na utafute ndani ya kidokezo unaposoma.",
    ),
    "whatsNewHomeSearchTitle": MessageLookupByLibrary.simpleMessage(
      "Tafuta kokote ",
    ),
    "whatsNewStreakTrackingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Fuatilia safu yako ya sasa, safu ndefu zaidi, jumla ya maneno na ramani ya joto ya shughuli ya miezi 6.",
    ),
    "whatsNewStreakTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Kuandika streaks na takwimu",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Binafsisha DiaryVault na rangi zako mwenyewe na mtindo wa kuona.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Kuunda na kufanya mada ziwe mahususi",
    ),
    "whatsNewTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Weka orodha kaguzi ndani ya vidokezo, unda todos za kujitegemea na ujulishwe kwa vikumbusho.",
    ),
    "whatsNewTodosTitle": MessageLookupByLibrary.simpleMessage(
      "Kila kitu chenye vikumbusho",
    ),
    "writingActivity": MessageLookupByLibrary.simpleMessage(
      "Shughuli ya uandishi",
    ),
    "writingActivityEmpty": MessageLookupByLibrary.simpleMessage(
      "Siku zako za kuandika zitaonekana hapa.",
    ),
    "writingActivityLess": MessageLookupByLibrary.simpleMessage("less"),
    "writingActivityMore": MessageLookupByLibrary.simpleMessage("Zaidi"),
    "writingActivityPeriod": MessageLookupByLibrary.simpleMessage("Miezi 6"),
    "writingActivityPrivacyNote": MessageLookupByLibrary.simpleMessage(
      "Maelezo yaliyosimbwa hayajumuishwi katika takwimu hizi.",
    ),
    "writingCurrentStreak": MessageLookupByLibrary.simpleMessage(
      "Msururu wa sasa",
    ),
    "writingDay": MessageLookupByLibrary.simpleMessage("siku"),
    "writingDays": MessageLookupByLibrary.simpleMessage("siku"),
    "writingLongestStreak": MessageLookupByLibrary.simpleMessage(
      "Mlolongo mrefu zaidi",
    ),
    "writingTotalWords": MessageLookupByLibrary.simpleMessage(
      "Jumla ya maneno",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("PIN isiyo sahihi"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Una mabadiliko ambayo hayajahifadhiwa",
    ),
    "youWillBeNotifiedAt": m4,
    "yourRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Msimbo wako wa kurejesha",
    ),
  };
}
