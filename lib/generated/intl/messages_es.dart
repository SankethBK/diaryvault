// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(imported, skipped, failed) =>
      "Notas ${imported} importadas, ${skipped} existentes, ${failed} fallidas";

  static String m1(imported, skipped) =>
      "Notas ${imported} importadas, notas ${skipped} existentes";

  static String m2(count) => "${count} notas importadas";

  static String m3(time) => "Serás notificado a las ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Acento"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Configuración de la cuenta exitosa",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "¿Ya tienes una cuenta?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Descubre diaryVault: una aplicación de diario diseñada para ayudarte a capturar tus pensamientos, recuerdos y momentos sin esfuerzo. ¡Disponible ahora en Play Store!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage(
      "Idioma de la aplicación",
    ),
    "appVersion": MessageLookupByLibrary.simpleMessage(
      "Versión de la aplicación",
    ),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "¿Estás seguro de querer cerrar sesión?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage(
      "Sincronización automática",
    ),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Guarda tus notas automáticamente cada 10 segundos",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Sincroniza automáticamente las notas con la nube",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Plataformas disponibles para sincronización",
    ),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "Al continuar, estás de acuerdo con nuestra",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Cámara"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "change": MessageLookupByLibrary.simpleMessage("Cambiar"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Cambiar color de fondo",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage(
      "Cambiar correo electrónico",
    ),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Cambiar frase de contraseña de cifrado",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Cambiar imagen"),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Cambiar contraseña",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Elige una imagen de fondo",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Elije la fuente de sincronización",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Elegir tema"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Elige la hora"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage(
      "¿Cerrar la aplicación?",
    ),
    "cloudBackup": MessageLookupByLibrary.simpleMessage(
      "Copia de seguridad en la nube",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirma la nueva contraseña",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Confirme su nuevo PIN",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Continuar como invitado",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Crear"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("Crea tu tema"),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Elige una foto que te guste o un color de fondo y crearemos un tema a su alrededor.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage(
      "Ruta de temas Personalizada",
    ),
    "dailyReminders": MessageLookupByLibrary.simpleMessage(
      "Recordatorios diarios",
    ),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Oscuro"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Tema oscuro"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Filtro por fecha"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Mi tema"),
    "delete": MessageLookupByLibrary.simpleMessage("Borrar"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage(
      "Falló la eliminación",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Hecho"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "¿No tienes una cuenta?",
    ),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Editar tema..."),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico actualizado con éxito, por favor inicia sesión nuevamente",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage(
      "Habilitar guardado automático",
    ),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Habilitar recordatorios diarios",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Habilitar inicio de sesión con huella digital",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Habilitar el cifrado de notas",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "Habilitar inicio DE sesión con PIN",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Cifre las notas confidenciales con una frase de contraseña que solo usted conozca. Las notas cifradas están protegidas en este dispositivo y en su copia de seguridad en la nube, y viven en una vista bloqueada separada.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage("Cifrar esta nota"),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage("Notas cifradas"),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Las notas cifradas están bloqueadas",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Cifrado"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Habilitado"),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Configurar una contraseña y un código de recuperación",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Introduce la contraseña actual",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage(
      "Introduce un nuevo correo electrónico",
    ),
    "enterPin": MessageLookupByLibrary.simpleMessage("Introduce tu PIN"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Introduce correo electrónico registrado",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Exporta tus notas"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("Exportar a JSON"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage(
      "Exportar a PDF (beta)",
    ),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Exportar a texto plano",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage(
      "Falló al buscar la nota",
    ),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage(
      "Falló al guardar la nota",
    ),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "La autenticación con huella digital debe estar habilitada en la configuración del dispositivo",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Falló el inicio de sesión con huella digital",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Tipo de letra"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Olvidé mi contraseña",
    ),
    "from": MessageLookupByLibrary.simpleMessage("Desde"),
    "gallery": MessageLookupByLibrary.simpleMessage("Galería"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Recibe recordatorios diarios a la hora que elijas para mantener tu diario al día.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Importar y exportar notas",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("Importar de JSON"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Frase de contraseña incorrecta",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Contraseña incorrecta",
    ),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Código de recuperación incorrecto.",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Archivo de copia de seguridad no válido.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Español"),
    "lastSynced": MessageLookupByLibrary.simpleMessage(
      "Última sincronización: ",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("Salir"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Claro"),
    "link": MessageLookupByLibrary.simpleMessage("Enlace"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Bloquear notas cifradas",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("Bloquear esta nota"),
    "logIn": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "logOut": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Por favor inicia sesión para habilitar la sincronización automática",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("Más información"),
    "muted": MessageLookupByLibrary.simpleMessage("Silenciada"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Aún no hay notas cifradas",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("No disponible"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Nota guardada con éxito",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Nota actualizada con éxito",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Sincronización de notas exitosa",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Tómate unos minutos para reflexionar sobre tu día en tu diario",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "No has seleccionado un tiempo de notificación",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "¡Hora de escribir en el diario!",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Las notificaciones no están habilitadas",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage(
      "Página no encontrada",
    ),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Paleta (toque una muestra para editarla)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Frase de contraseña"),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico de restablecimiento de contraseña enviado",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Restablecimiento de contraseña exitoso",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Contraseña verificada",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Las contraseñas no coinciden",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Escoge un color"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Selecciona un color de fondo",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage(
      "Elegir de archivos",
    ),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage("Login Failed"),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "Se mostrará un PIN de hasta 4 dígitos en la pantalla de bloqueo",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Introduzca un año en formato de 4 dígitos",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Sensación DE confirmación de PIN",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Los números PIN no coinciden",
    ),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage(
          "Por favor configura tu cuenta para usar esta función",
        ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de privacidad",
    ),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage(
      "Proyecto en GitHub",
    ),
    "recordAudio": MessageLookupByLibrary.simpleMessage("Burn Image to Disc"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage(
      "Código de recuperación",
    ),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Regenerar código de recuperación",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Recordatorios"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Eliminar cifrado de esta nota",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Restablecer contraseña",
    ),
    "resetPin": MessageLookupByLibrary.simpleMessage("Restablecer el PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage(
      "¿Deseas aplicar el tema?",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Guardar cambios"),
    "security": MessageLookupByLibrary.simpleMessage("Seguridad"),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Configuraciones de seguridad",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Seleccionar"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Seleccionar voz"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Enviar comentarios"),
    "settings": MessageLookupByLibrary.simpleMessage("Configuraciones"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage(
      "Configura tu cuenta",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Compartir con amigos",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "Iniciar sesión con email",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Registrarse"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Ingresado como"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage(
      "Ordenar de la A a la Z",
    ),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "Ordenar por lo más reciente primero",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "Ordenar por lo más antiguo primero",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("Quedarse"),
    "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Sincronizar ahora"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "La etiqueta ya existe",
    ),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Toca aquí para expandir el título",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Personalizar tema, fuentes e idioma",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Nombre del tema"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Mi tema"),
    "to": MessageLookupByLibrary.simpleMessage("Hasta"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Demasiados intentos incorrectos, por favor inicia sesión con contraseña",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "~Bloquear posición de la barra de herramientas",
    ),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Ocurrió un error inesperado",
    ),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Desbloquear notas cifradas",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Desbloquear esta nota",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("URL de WebDAV"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Qué hay de nuevo"),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Proteja las notas confidenciales con opciones de cifrado y recuperación basadas en frases de contraseña.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Acerca del cifrado",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Personaliza DiaryVault con tus propios colores y estilo visual.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Creación y personalización de temas",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("PIN incorrecto"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Tienes cambios sin guardar",
    ),
    "youWillBeNotifiedAt": m3,
  };
}
