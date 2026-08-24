// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fi locale. All the
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
  String get localeName => 'fi';

  static String m0(imported, skipped, failed) =>
      "Tuotu ${imported} muistiinpanoa, ohitettu ${skipped} olemassa, ${failed} epäonnistui";

  static String m1(imported, skipped) =>
      "Tuotu ${imported} muistiinpanoa, ohitettu ${skipped} olemassa olevaa muistiinpanoa";

  static String m2(count) => "Tuodut ${count} muistiinpanoa";

  static String m3(time) => "Ilmoitusajankohta: ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Korostus"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Tilin määritys onnistui",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Oletko jo rekisteröitynyt?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Tutustu diaryVaultiin – muistikirjasovellukseen, joka auttaa säilömään ajatukset, muistot ja hetket vaivattomasti. Saatavilla nyt Play Store -kaupasta!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("Sovelluksen kieli"),
    "appVersion": MessageLookupByLibrary.simpleMessage("Sovelluksen versio"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "Haluatko varmasti kirjautua ulos?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage(
      "Automaattinen synkronointi",
    ),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Tallentaa muistiinpanosi automaattisesti 10 sekunnin välein",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Synkronoi muistiinpanot pilvipalveluun automaattisesti",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Synkronointia tukevat alustat",
    ),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "Jos jatkat, hyväksyt",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Kamera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Peruuta"),
    "change": MessageLookupByLibrary.simpleMessage("Muuta"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Muuta taustaväriä",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage(
      "Vaihda sähköpostiosoite",
    ),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Vaihda salaussalasana",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Vaihda kuva"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Vaihda salasana"),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Valitse taustakuva",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Valitse synkronointilähde",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Valitse teema"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Valitse ajankohta"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage(
      "Suljetaanko sovellus?",
    ),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("Pilvivarmennus"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Vahvista uusi salasana",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Vahvista uusi PIN-koodi",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Jatka vieraskäyttäjänä",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Luo "),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("Luo teemasi"),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Valitse kuva, josta pidät, tai taustaväri, niin rakennamme teeman sen ympärille.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("Mukautetut teemat"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage(
      "Päivittäiset muistutukset",
    ),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Tumma"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Tumma teema"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Päivämääräsuodatin"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Oma teema"),
    "delete": MessageLookupByLibrary.simpleMessage("Poista"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage(
      "Poisto ei onnistunut",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Valmis"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Eikö sinulla ole tiliä?",
    ),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Muokkaa teemaa"),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Sähköpostiosoite on päivitetty. Kirjaudu uudelleen sisään.",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage(
      "Ota automaattinen tallennus käyttöön",
    ),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Ota päivittäiset muistutukset käyttöön",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Ota sormenjälkitunnistus käyttöön",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Ota muistiinpanojen salaus käyttöön",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "Ota PIN-kirjautuminen käyttöön",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Salaa arkaluonteiset muistiinpanot tunnuslauseella, jonka vain sinä tiedät. Salatut muistiinpanot on suojattu tällä laitteella ja pilvivarmistuksessasi, ja ne näkyvät erillisessä lukitussa näkymässä.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage(
      "Salaa tämä huomautus",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Salatut muistiinpanot",
    ),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Salatut muistiinpanot on lukittu",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Salaus"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Käytössä"),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Aseta tunnuslause ja palautuskoodi",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Anna nykyinen salasana",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage(
      "Anna uusi sähköpostiosoite",
    ),
    "enterPin": MessageLookupByLibrary.simpleMessage("Syötä PIN-koodisi"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Anna rekisteröity sähköpostiosoite",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Vie muistiinpanosi"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("Vie JSON:ksi"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage("Vie PDF:ksi"),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Vie tekstimuotoon",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage(
      "Muistiinpanon haku ei onnistunut",
    ),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage(
      "Muistiinpanon tallennus ei onnistunut",
    ),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "Sormenjälkitunnistus on otettava käyttöön laitteen asetuksissa",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Sormenjälkitunnistus ei onnistunut",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Fontti"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Unohtuiko salasana?",
    ),
    "from": MessageLookupByLibrary.simpleMessage("Alku"),
    "gallery": MessageLookupByLibrary.simpleMessage("Galleria"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Saat päivittäisen muistutuksen kirjoittaa muistikirjaan haluamanasi ajankohtana.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Tuo ja vie muistiinpanoja",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("Tuo paikasta"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Virheellinen tunnuslause",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Salasana on väärä",
    ),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Virheellinen palautuskoodi",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Virheellinen varmuuskopiotiedosto",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Finnish"),
    "lastSynced": MessageLookupByLibrary.simpleMessage(
      "Viimeksi synkronoitu: ",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("Poistu"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Kevyt"),
    "link": MessageLookupByLibrary.simpleMessage("Linkki"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Lukitse salatut muistiinpanot",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage(
      "Lukitse tämä muistiinpano",
    ),
    "logIn": MessageLookupByLibrary.simpleMessage("Kirjaudu sisään"),
    "logOut": MessageLookupByLibrary.simpleMessage("Kirjaudu ulos"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Kirjaudu ulos"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Ota automaattinen synkronointi käyttöön kirjautumalla sisään",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("Lisätietoja"),
    "muted": MessageLookupByLibrary.simpleMessage("Mykistetty"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Uusi salasana"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Ei vielä salattuja muistiinpanoja",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Ei käytettävissä"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Muistiinpano on tallennettu",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Muistiinpano on päivitetty",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Muistiinpanot on synkronoitu",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Pysähdy hetkeksi tallentamaan päivän ajatuksiasi muistikirjaan",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Ilmoitusajankohtaa ei ole valittu",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "Aika kirjoittaa muistikirjaan!",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Ilmoituksia ei ole otettu käyttöön",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage("Sivua ei löydy"),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Paletti (napauta värimallia muokataksesi)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Salauslause:"),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "Salasanan palautusviesti on lähetetty",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Salasanan palautus onnistui",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Salasana on vahvistettu",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Salasanat eivät täsmää",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Valitse väri"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Valitse sen sijaan taustaväri",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage(
      "Valitse tiedostoista",
    ),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Sisäänkirjautuminen epäonnistui",
    ),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "Lukitusnäytöllä näytetään enintään 4-numeroinen PIN-koodi",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Anna nelinumeroinen PIN-koodi",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "PIN-vahvistuksen tunne",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage(
      "PIN-koodit eivät täsmää",
    ),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage(
          "Ominaisuus edellyttää, että tili on määritetty",
        ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "sovelluksen tietosuojakäytännön",
    ),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage(
      "Projekti Githubissa",
    ),
    "recordAudio": MessageLookupByLibrary.simpleMessage("Nauhoita ääntä"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage("Palautuskoodi"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Luo palautuskoodi uudelleen",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Muistutukset"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Poista salaus tästä huomautuksesta",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Nollaa salasana"),
    "resetPin": MessageLookupByLibrary.simpleMessage("Nollaa PIN-koodi"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage(
      "Tallenna ja käytä teemaa",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Tallenna muutokset"),
    "security": MessageLookupByLibrary.simpleMessage("Suojaus"),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Suojausasetukset",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Valitse"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Valitse ääni"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Lähetä palautetta"),
    "settings": MessageLookupByLibrary.simpleMessage("Asetukset"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage("Määritä tilisi"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Kerro sovelluksesta ystäville",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Rekisteröidy"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "Kirjaudu sisään sähköpostiosoitteella",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Rekisteröidy"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Kirjautuneena:"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage("Lajitteluperuste: A-Z"),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "Lajittele uusin ensin",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "Lajittele vanhin ensin",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("Jää"),
    "submit": MessageLookupByLibrary.simpleMessage("Lähetä"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Synkronoi nyt"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Tunniste on jo olemassa",
    ),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Laajenna otsikko napauttamalla tätä",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Muokkaa teemaa, fontteja ja kieltä",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Teema"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Oma teema"),
    "to": MessageLookupByLibrary.simpleMessage("Loppu"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Tunnistus epäonnistui liian monta kertaa. Anna salasana.",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Työkalurivin sijainti",
    ),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "On ilmennyt odottamaton virhe",
    ),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Avaa salattujen muistiinpanojen lukitus",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Avaa tämän muistiinpanon lukitus",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("WebDAV-URL-osoite"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Mitä uutta"),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Suojaa arkaluonteiset muistiinpanot salasanafraasipohjaisella salauksella ja palautusvaihtoehdoilla.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Tietoja salauksesta",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tee DiaryVaultista yksilöllinen omilla väreilläsi ja visuaalisella tyylilläsi.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Teemojen luominen ja muokkaaminen",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("Väärä PIN-koodi"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Muutoksia ei ole tallennettu",
    ),
    "youWillBeNotifiedAt": m3,
  };
}
