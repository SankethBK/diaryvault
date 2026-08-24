// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(imported, skipped, failed) =>
      "Notes ${imported} importées, ignorées ${skipped} existantes, échec de ${failed}";

  static String m1(imported, skipped) =>
      "Notes ${imported} importées, notes existantes ${skipped} ignorées";

  static String m2(count) => "${count} notes importées";

  static String m3(time) => "Vous serez averti à ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Accent"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Configuration du compte réussie",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un compte?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Découvrez diaryVault - une application de journal conçue pour vous aider à capturer vos pensées, vos souvenirs et vos moments sans effort. Disponible dès maintenant sur le Play Store !",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage(
      "Langue de l\'application",
    ),
    "appVersion": MessageLookupByLibrary.simpleMessage(
      "Version de l\'application",
    ),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "Etes-vous sûr de vous déconnecter ?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser le mot de passe",
    ),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Enregistre automatiquement vos notes toutes les 10 secondes",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Synchronisez automatiquement les notes avec le cloud",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Plateformes disponibles pour la synchronisation",
    ),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "En continuant, vous acceptez notre",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Caméra"),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "change": MessageLookupByLibrary.simpleMessage("Changer"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Modifier la couleur de l\'arrière-plan",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage("Changer l\'e-mail"),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Modifier la phrase de passe de chiffrement",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Modifier l\'image"),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Changer le mot de passe",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Choisir l\'image de fond",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Choisissez la source de synchronisation",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Choisir un thème"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Choisissez l\'heure"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage(
      "Fermer l\'application ?",
    ),
    "cloudBackup": MessageLookupByLibrary.simpleMessage(
      "Sauvegarde dans le Cloud",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmer le nouveau mot de passe",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Confirmez votre nouveau code PIN",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Continuer en tant qu\'invité",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Créer"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage(
      "Pack de création de thèmes",
    ),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Choisissez une photo que vous aimez ou choisissez une couleur d\'arrière-plan, et nous créerons un thème autour de celle-ci.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage(
      "Champs personnalisés",
    ),
    "dailyReminders": MessageLookupByLibrary.simpleMessage(
      "Rappels quotidiens",
    ),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Foncé"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Thème foncé"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Filtre de dates"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Mon thème"),
    "delete": MessageLookupByLibrary.simpleMessage("Fait"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage(
      "La suppression a échoué",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Fait"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas de compte ?",
    ),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Modifier le thème"),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "E-mail mis à jour avec succès, veuillez vous reconnecter",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage(
      "Activer la sauvegarde automatique",
    ),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Activer les rappels quotidiens",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Activer la connexion par empreinte digitale",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Activer le cryptage des notes",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "Activer la connexion PAR CODE PIN",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Chiffrez les notes sensibles avec une phrase de passe que vous seul connaissez. Les notes cryptées sont protégées sur cet appareil et dans votre sauvegarde cloud, et vivent dans une vue verrouillée séparée.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage(
      "Chiffrer cette note",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage("Notes chiffrées"),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Les notes chiffrées sont verrouillées",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Chiffrement"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Activée"),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Configurez une phrase secrète et un code de récupération",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Entrer le mot de passe actuel",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage(
      "Entrez un nouvel e-mail",
    ),
    "enterPin": MessageLookupByLibrary.simpleMessage("Saisissez votre code"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Entrez l\'e-mail enregistré",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Exportez vos notes"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("Exporter vers JSON"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage(
      "Exporter au format PDF (bêta)",
    ),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Exporter vers du texte brut",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage(
      "Échec de la récupération de la note",
    ),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage(
      "Échec de l\'enregistrement de la note",
    ),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "L\'authentification par empreinte digitale doit être activée dans les paramètres de l\'appareil",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "La connexion par empreinte digitale a échoué",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Famille de Polices"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublié",
    ),
    "from": MessageLookupByLibrary.simpleMessage("Depuis"),
    "gallery": MessageLookupByLibrary.simpleMessage("Galerie"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Recevez des rappels quotidiens à l\'heure que vous avez choisie pour garder votre journal à jour.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Importer et exporter des notes",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage(
      "Importation de JSON",
    ),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Phrase de passe incorrecte",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Mot de passe incorrect",
    ),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Code de récupération incorrect",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Fichier de sauvegarde invalide",
    ),
    "language": MessageLookupByLibrary.simpleMessage("French"),
    "lastSynced": MessageLookupByLibrary.simpleMessage(
      "Dernière synchronisation : ",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("Partir"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Legere"),
    "link": MessageLookupByLibrary.simpleMessage("Lien"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Verrouiller les notes cryptées",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage(
      "Verrouiller cette note",
    ),
    "logIn": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "logOut": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Veuillez vous connecter pour activer la synchronisation automatique",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("Plus d\'informations"),
    "muted": MessageLookupByLibrary.simpleMessage("Mis en sourdine"),
    "newPassword": MessageLookupByLibrary.simpleMessage("nouveau mot de passe"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Pas encore de notes chiffrées",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Pas disponible"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Note enregistrée avec succès",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Remarque mise à jour avec succès",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Synchronisation des notes réussie",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Prenez quelques minutes pour réfléchir à votre journée dans votre agenda",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas sélectionné d\'heure de notification",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "Il est temps de rédiger un journal !",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Les notifications ne sont pas activées",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage("Page non trouvée"),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Palette (appuyez sur un échantillon pour le modifier)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Phrase secrète"),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "E-mail de réinitialisation du mot de passe envoyé",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Réinitialisation du mot de passe réussie",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Mot de passe vérifié",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Choisir une couleur"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Choisissez une couleur d’arrière-plan",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage(
      "Choisir dans les fichiers",
    ),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage(
      "La connexion a échoué",
    ),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "Un code PIN allant jusqu\'à 4 chiffres sera demandé sur l\'écran de verrouillage",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Veuillez entrer une année au format de 4 chiffres",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Sensation DE confirmation du NIP",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Les PIN ne correspondent pas.",
    ),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage(
          "Veuillez configurer votre compte pour utiliser cette fonctionnalité",
        ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "politique de confidentialité",
    ),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage(
      "Projet sur Github",
    ),
    "recordAudio": MessageLookupByLibrary.simpleMessage("Enregistrer l’audio"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage(
      "Code de récupération",
    ),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Régénérer le code de récupération",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Rappels"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Supprimer le chiffrement de cette note",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser le mot de passe",
    ),
    "resetPin": MessageLookupByLibrary.simpleMessage("Réinitialiser le NIP"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage(
      "Appliquer le thème",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Enregistrer les modifications",
    ),
    "security": MessageLookupByLibrary.simpleMessage("Sécurité"),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Les paramètres de sécurité",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Sélectionner"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Sélectionnez la voix"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage(
      "Envoyer des commentaires",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage(
      "Configurez votre compte",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Partager avec des amis",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous avec une adresse électronique",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Connecté en tant que"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage(
      "Trier par le plus ancien en premier",
    ),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "Trier par le plus récent en premier",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "Trier par le plus ancien en premier",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("rester"),
    "submit": MessageLookupByLibrary.simpleMessage("Soumettre"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Synchroniser maintenant"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "La balise existe déjà",
    ),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Appuyez ici pour développer le titre",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Personnaliser le thème, les polices et la langue",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Nom du thème"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Mon thème"),
    "to": MessageLookupByLibrary.simpleMessage("À"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Trop de mauvaises tentatives, veuillez vous connecter avec votre mot de passe",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Position de la barre d\'outils",
    ),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Une erreur inattendue s\'est produite",
    ),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Déverrouiller les notes cryptées",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Déverrouiller cette note",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Vidéo"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("URL WebDAV"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Quoi de neuf"),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Protégez les notes sensibles avec des options de chiffrement et de récupération basées sur des mots de passe.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "À propos du cryptage :",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Personnalisez DiaryVault avec vos propres couleurs et style visuel.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Création et personnalisation de thèmes",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("PIN incorrect"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Vous avez des changements non enregistrés",
    ),
    "youWillBeNotifiedAt": m3,
  };
}
