// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  static String m0(imported, skipped, failed) =>
      "Zaimportowano ${imported} notatek, pominięto ${skipped} istniejących, ${failed} nie powiodło się";

  static String m1(imported, skipped) =>
      "Zaimportowano ${imported} notatek, pominięto ${skipped} istniejących notatek";

  static String m2(count) => "Zaimportowano ${count} notatek";

  static String m3(time) => "Zostaniesz powiadomiony/-a o ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Akcent"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Konfiguracja konta ukończona sukcesem",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Masz już konto?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "DiaryVault - pamiętnik na telefon, stworzony w celu łatwego zapisywania myśli, wspomnień i chwil. Dostępny w Sklepie Play!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("Język aplikacji"),
    "appVersion": MessageLookupByLibrary.simpleMessage("Wersja aplikacji"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "Na pewno chcesz się wylogować?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage("Autosynchronizacja"),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Zapisz notatki automatycznie co 10 sekund",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Synchronizuj notatki z chmurą automatycznie",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Dostępne platformy do synchronizacji",
    ),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "Kontynuując, akceptujesz naszą",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Aparat"),
    "cancel": MessageLookupByLibrary.simpleMessage("Anuluj"),
    "change": MessageLookupByLibrary.simpleMessage("Zmień"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Zmień kolor tła",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage("Zmień adres email"),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Zmień hasło szyfrowania",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Zmień obraz"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Zmień hasło"),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Wybierz obraz tła",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Wybierz sposób synchronizacji",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Wybierz motyw"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Wybierz godzinę"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("Wyłączyć aplikację?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage(
      "Kopia zapasowa w chmurze",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Potwierdź nowe hasło",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage("Potwierdź nowy PIN"),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Kontynuuj jako gość",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Stwórz"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage(
      "Stwórz swój motyw",
    ),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Wybierz zdjęcie, które Ci się podoba, lub wybierz kolor tła, a wokół niego zbudujemy motyw przewodni.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage(
      "Motywy niestandardowe",
    ),
    "dailyReminders": MessageLookupByLibrary.simpleMessage(
      "Codzienne przypomnienia",
    ),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Mroczny/a/e"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Ciemna kompozycja"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Filtruj według daty"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Mój temat"),
    "delete": MessageLookupByLibrary.simpleMessage("Usuń"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage(
      "Usunięcie nie powiodło się",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Gotowe"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("Nie masz konta?"),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Edytuj Motyw"),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Adres email zaktualizowany pomyślnie, zaloguj się ponownie",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage("Włącz autozapis"),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Włącz codzienne przypomnienia",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Logowanie czytnikiem linii papilarnych",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Włącz szyfrowanie notatek",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "Logowanie kodem PIN",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Szyfruj poufne notatki za pomocą hasła, które znasz tylko Ty. Zaszyfrowane notatki są chronione na tym urządzeniu i w kopii zapasowej w chmurze i żyją w oddzielnym zablokowanym widoku.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage(
      "Zaszyfruj tę notatkę",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Zaszyfrowane notatki",
    ),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "610, \"Zaszyfrowane notatki są zablokowane. ",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Szyfrowanie"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Włączony"),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Skonfiguruj hasło i kod odzyskiwania",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Wprowadź aktualne hasło",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage(
      "Wprowadź nowy adres email",
    ),
    "enterPin": MessageLookupByLibrary.simpleMessage("Wprowadź PIN"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Wprowadź zarejestrowany adres email",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Eksportuj notatki"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage(
      "Wyeksportuj do pliku JSON",
    ),
    "exportToPDF": MessageLookupByLibrary.simpleMessage(
      "Wyeksportuj do pliku PDF",
    ),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Wyeksportuj jako zwykły tekst",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage(
      "Nie udało się pobrać notatki",
    ),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage(
      "Nie udało się zapisać notatki",
    ),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "Logowanie czytnikiem linii papilarnych musi zostać włączone w ustawieniach urządzenia",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Logowanie czytnikiem papilarnym nie powiodło się",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Czcionka"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Nie pamiętam hasła",
    ),
    "from": MessageLookupByLibrary.simpleMessage("Od"),
    "gallery": MessageLookupByLibrary.simpleMessage("Galeria"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Otrzymuj codzienne przypomnienia o wybranej porze, aby aktualizować pamiętnik.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Dysk Google"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Importuj i eksportuj notatki",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("Importuj z"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Błędne hasło.",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Nieprawidłowe hasło",
    ),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Nieprawidłowy kod odzyskiwania.",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Nieprawidłowy plik kopii zapasowej.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Polski"),
    "lastSynced": MessageLookupByLibrary.simpleMessage(
      "Ostatnia synchronizacja: ",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("Wyjdź"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Podpal"),
    "link": MessageLookupByLibrary.simpleMessage("Łącze"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Zablokuj zaszyfrowane notatki",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("Zablokuj tę notatkę"),
    "logIn": MessageLookupByLibrary.simpleMessage("Zaloguj się"),
    "logOut": MessageLookupByLibrary.simpleMessage("Wyloguj się"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Wyloguj się"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Zaloguj się aby włączyć autosynchronizację",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("Więcej informacji"),
    "muted": MessageLookupByLibrary.simpleMessage("Wyciszenie"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nowe hasło"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Brak zaszyfrowanych notatek",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Niedostępne"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Notatka zapisana pomyślnie",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Notatka zaktualizowana pomyślnie",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Synchronizacja notatek pomyślna",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Poświęć kilka minut na refleksję i wpis w pamiętniku",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Nie wybrano godziny dostarczenia powiadomień",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "Czas na wpisy w pamiętniku!",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Powiadomienia wyłączone",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage(
      "Nie odnaleziono strony",
    ),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Paleta (dotknij próbki, aby edytować)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Hasło"),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "Wysłano email z linkiem do zresetowania hasła",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Hasło zmienione pomyślnie",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Hasło zweryfikowane",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Hasła nie są takie same",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Wybierz kolor"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Wybierz kolor tła",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage(
      "Wybierz w menedżerze plików",
    ),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Logowanie kodem PIN niepomyślne",
    ),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "Odblokuj aplikację 4-cyfrowym kodem PIN",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Wprowadź 4-cyfrowy kod PIN",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "PIN zresetowany pomyślnie",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage("PIN się nie zgadza"),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage(
          "Zaloguj się, aby skorzystać z tej funkcji",
        ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "politykę prywatności",
    ),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage(
      "Projekt na platformie GitHub",
    ),
    "recordAudio": MessageLookupByLibrary.simpleMessage("Nagraj dźwięk"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage("Kod odzyskiwania"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Wygeneruj ponownie kod odzyskiwania",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Przypomnienia"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Usuń szyfrowanie z tej notatki",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Zmień hasło"),
    "resetPin": MessageLookupByLibrary.simpleMessage("Resetuj numer PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage("Zastosuj motyw"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Zapisz zmiany"),
    "security": MessageLookupByLibrary.simpleMessage("Bezpieczeństwo"),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Ustawienia bezpieczeństwa",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Wybierz"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Wybierz głos"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Wyślij opinię"),
    "settings": MessageLookupByLibrary.simpleMessage("Ustawienia"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage(
      "Skonfiguruj swoje konto",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Udostępnij znajomym",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Zaloguj się"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "Zaloguj się używając adresu email",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Zarejestruj się"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Zalogowany/-a jako"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage("Sortuj alfabetycznie"),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "Sortuj od najnowszych",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "Sortuj od najstarszych",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("Zostań"),
    "submit": MessageLookupByLibrary.simpleMessage("Zatwierdź"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Synchronizuj teraz"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Ta etykieta już istnieje",
    ),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Dotknij tutaj, aby rozwinąć tytuł",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Personalizuj motyw, czcionki i język",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Nazwa motywu"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Mój temat"),
    "to": MessageLookupByLibrary.simpleMessage("Do"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Za dużo nieudanych prób, zaloguj się hasłem",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Pozycja paska narzędzi",
    ),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Niespodziewany błąd",
    ),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Odblokuj zaszyfrowane notatki",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Odblokuj tę notatkę",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Kamera"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Nowości"),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Chroń poufne notatki za pomocą opcji szyfrowania i odzyskiwania opartych na hasłach.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "O szyfrowaniu",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Spersonalizuj DiaryVault za pomocą własnych kolorów i stylu wizualnego.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Tworzenie i dostosowywanie motywów",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("Nieprawidłowy kod PIN"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Masz niezapisane zmiany",
    ),
    "youWillBeNotifiedAt": m3,
  };
}
