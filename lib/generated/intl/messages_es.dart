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

  static String m3(minLength) =>
      "La frase de contraseña debe tener al menos ${minLength} caracteres";

  static String m4(time) => "Serás notificado a las ${time}";

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
    "appTitle": MessageLookupByLibrary.simpleMessage("Mis productos lácteos"),
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
    "backAction": MessageLookupByLibrary.simpleMessage("Atrás"),
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
    "changePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Cambiar frase de contraseña",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Cambiar contraseña",
    ),
    "changeReminderTime": MessageLookupByLibrary.simpleMessage(
      "Cambiar recordatorio",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Elige una imagen de fondo",
    ),
    "choosePassphraseHint": MessageLookupByLibrary.simpleMessage(
      "Introducirás esto para desbloquear notas cifradas. Usa algo largo y memorable.",
    ),
    "choosePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Elige una frase de contraseña",
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
    "confirmNewPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmar nueva contraseña",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirma la nueva contraseña",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Confirme su nuevo PIN",
    ),
    "confirmPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Continuar como invitado",
    ),
    "continueButton": MessageLookupByLibrary.simpleMessage("Continuar"),
    "copyButtonTooltip": MessageLookupByLibrary.simpleMessage("Copy"),
    "create": MessageLookupByLibrary.simpleMessage("Crear"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("Crea tu tema"),
    "currentPassphraseIncorrect": MessageLookupByLibrary.simpleMessage(
      "La frase de contraseña actual es incorrecta",
    ),
    "currentPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Contraseña actual",
    ),
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
    "dashboardAddTodo": MessageLookupByLibrary.simpleMessage("Agregar un todo"),
    "dashboardAnotherPrompt": MessageLookupByLibrary.simpleMessage(
      "Otra indicación",
    ),
    "dashboardComingSoon": MessageLookupByLibrary.simpleMessage("En breve"),
    "dashboardCompletedTodos": MessageLookupByLibrary.simpleMessage(
      "Finalizado",
    ),
    "dashboardCreateTodo": MessageLookupByLibrary.simpleMessage("Añadir"),
    "dashboardDailyPrompt": MessageLookupByLibrary.simpleMessage(
      "Aviso diario:",
    ),
    "dashboardDailyPrompt1": MessageLookupByLibrary.simpleMessage(
      "¿Qué se sintió como una pequeña victoria para mí hoy?",
    ),
    "dashboardDailyPrompt2": MessageLookupByLibrary.simpleMessage(
      "¿Qué momento de hoy quiero recordar?",
    ),
    "dashboardDailyPrompt3": MessageLookupByLibrary.simpleMessage(
      "¿Qué requirió más energía de la que esperaba hoy?",
    ),
    "dashboardDailyPrompt4": MessageLookupByLibrary.simpleMessage(
      "¿Qué puedo dejar ir esta noche?",
    ),
    "dashboardDailyPrompt5": MessageLookupByLibrary.simpleMessage(
      "¿Qué aprendí sobre mí hoy?",
    ),
    "dashboardDailyPrompt6": MessageLookupByLibrary.simpleMessage(
      "¿Qué me hizo el día un poco más fácil?",
    ),
    "dashboardDailyPrompt7": MessageLookupByLibrary.simpleMessage(
      "¿Qué haría que mañana se sintiera más amable para mí?",
    ),
    "dashboardDailyPrompt8": MessageLookupByLibrary.simpleMessage(
      "¿Qué me hizo sentir agradecido hoy?",
    ),
    "dashboardDueToday": MessageLookupByLibrary.simpleMessage("A pagar hoy"),
    "dashboardEditTodo": MessageLookupByLibrary.simpleMessage("Editar tarea"),
    "dashboardMoodCheckIn": MessageLookupByLibrary.simpleMessage(
      "Registro de entrada",
    ),
    "dashboardMoodContextPrompt": MessageLookupByLibrary.simpleMessage(
      "¿Quieres añadir un poco de contexto?",
    ),
    "dashboardMoodDifficult": MessageLookupByLibrary.simpleMessage(
      "Tener un día difícil",
    ),
    "dashboardMoodGood": MessageLookupByLibrary.simpleMessage("Bien"),
    "dashboardMoodGreat": MessageLookupByLibrary.simpleMessage("Grandes"),
    "dashboardMoodLow": MessageLookupByLibrary.simpleMessage("No muy bien"),
    "dashboardMoodNoteTitle": MessageLookupByLibrary.simpleMessage(
      "Reflexion del dia!",
    ),
    "dashboardMoodOkay": MessageLookupByLibrary.simpleMessage("Regular"),
    "dashboardMoodOpeningDifficult": MessageLookupByLibrary.simpleMessage(
      "Hoy ha sido un día duro.",
    ),
    "dashboardMoodOpeningGood": MessageLookupByLibrary.simpleMessage(
      "\"Bien, hoy me encuentro bien\".",
    ),
    "dashboardMoodOpeningGreat": MessageLookupByLibrary.simpleMessage(
      "Hoy me siento muy bien.",
    ),
    "dashboardMoodOpeningLow": MessageLookupByLibrary.simpleMessage(
      "Hoy no me siento bien.",
    ),
    "dashboardMoodOpeningOkay": MessageLookupByLibrary.simpleMessage(
      "Hoy me siento bien.",
    ),
    "dashboardMoodReflectionHint": MessageLookupByLibrary.simpleMessage(
      "¿Tienes algo más en mente? (opcional)",
    ),
    "dashboardMoodSaveToJournal": MessageLookupByLibrary.simpleMessage(
      "Añadir a la nota de hoy",
    ),
    "dashboardMoodSubtitle": MessageLookupByLibrary.simpleMessage(
      "¿Cómo va su salud?",
    ),
    "dashboardNoDueDate": MessageLookupByLibrary.simpleMessage(
      "No hay fecha de vencimiento",
    ),
    "dashboardNoTodos": MessageLookupByLibrary.simpleMessage(
      "Todavía no hay todos aquí",
    ),
    "dashboardNoTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tus tareas abiertas y completadas aparecerán aquí.",
    ),
    "dashboardOpenInNote": MessageLookupByLibrary.simpleMessage(
      "Abrir en nota",
    ),
    "dashboardOpenTodos": MessageLookupByLibrary.simpleMessage("Abrir"),
    "dashboardOverdue": MessageLookupByLibrary.simpleMessage("Vencido"),
    "dashboardPromptSubtitle": MessageLookupByLibrary.simpleMessage(
      "Una pequeña pregunta para reflexionar",
    ),
    "dashboardQuickCapture": MessageLookupByLibrary.simpleMessage(
      "Captura rápida",
    ),
    "dashboardReminderOptional": MessageLookupByLibrary.simpleMessage(
      "Recordatorio establecido",
    ),
    "dashboardSaveTodo": MessageLookupByLibrary.simpleMessage("Guardar"),
    "dashboardToday": MessageLookupByLibrary.simpleMessage("En la actualidad"),
    "dashboardTodoLoadFailed": MessageLookupByLibrary.simpleMessage(
      "No se han podido cargar todos",
    ),
    "dashboardTodoRequired": MessageLookupByLibrary.simpleMessage(
      "Introduzca un todo primero",
    ),
    "dashboardTodoSourceHint": MessageLookupByLibrary.simpleMessage(
      "Todos se pueden añadir desde una nota o crear directamente aquí.",
    ),
    "dashboardTodoTitle": MessageLookupByLibrary.simpleMessage(
      "¿Qué hay que hacer?",
    ),
    "dashboardTodoUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "No se ha podido actualizar esta tarea",
    ),
    "dashboardTodos": MessageLookupByLibrary.simpleMessage("Todas"),
    "dashboardUpcoming": MessageLookupByLibrary.simpleMessage("Próximas"),
    "dashboardWriteAboutPrompt": MessageLookupByLibrary.simpleMessage(
      "Escribe sobre:",
    ),
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
    "editorPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Escribir algo...",
    ),
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
    "encryptYourNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Las notas que marcas como cifradas están protegidas en este dispositivo y en tu copia de seguridad en la nube con una frase de contraseña que solo tú conoces. Nadie más, incluidos nosotros y su proveedor de servicios en la nube, puede leerlos.",
    ),
    "encryptYourNotesTitle": MessageLookupByLibrary.simpleMessage(
      "Cifra tus notas",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage("Notas cifradas"),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Las notas cifradas están bloqueadas",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Cifrado"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Habilitado"),
    "encryptionEnabledToast": MessageLookupByLibrary.simpleMessage(
      "Cifrado habilitado",
    ),
    "encryptionLossAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Entiendo que no hay forma de recuperar mis notas si olvido esta frase de contraseña y pierdo el código de recuperación",
    ),
    "encryptionLossWarning": MessageLookupByLibrary.simpleMessage(
      "⚠️ Si olvida su contraseña Y pierde el código de recuperación, las notas cifradas desaparecerán para siempre. No hay forma de recuperarlos.",
    ),
    "encryptionSeparateViewDescription": MessageLookupByLibrary.simpleMessage(
      "Las notas cifradas viven en una vista bloqueada separada y están excluidas de la búsqueda.",
    ),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Configurar una contraseña y un código de recuperación",
    ),
    "encryptionStaysOnToast": MessageLookupByLibrary.simpleMessage(
      "El cifrado permanece activado para las notas cifradas. Bloquéalos en cualquier momento desde la vista de notas cifradas.",
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
    "forgotPassphraseUseRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "¿Olvidó su contraseña? Utilice el código de recuperación",
    ),
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
    "lockAction": MessageLookupByLibrary.simpleMessage("Bloqueo"),
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
    "newPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Nueva contraseña",
    ),
    "newPassphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Las nuevas frases de contraseña no coinciden",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
    "newRecoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "He escrito el nuevo código",
    ),
    "newRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Anótelo y manténgalo a salvo. No se volverá a mostrar.",
    ),
    "newRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Nuevo código de recuperación",
    ),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Aún no hay notas cifradas",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("No disponible"),
    "notNow": MessageLookupByLibrary.simpleMessage("Ahora no"),
    "noteCollapsePreview": MessageLookupByLibrary.simpleMessage(
      "Contraer vista previa",
    ),
    "noteDifferentPassphrase": MessageLookupByLibrary.simpleMessage(
      "Esta nota está protegida por una contraseña diferente",
    ),
    "noteExpandPreview": MessageLookupByLibrary.simpleMessage(
      "Expandir vista previa",
    ),
    "noteNoTitle": MessageLookupByLibrary.simpleMessage("Nota sin título"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Nota guardada con éxito",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Nota actualizada con éxito",
    ),
    "noteWillBeSavedEncrypted": MessageLookupByLibrary.simpleMessage(
      "La nota se guardará encriptada",
    ),
    "noteWillBeSavedUnencrypted": MessageLookupByLibrary.simpleMessage(
      "La nota se guardará sin cifrar",
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
    "passphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Frase de contraseña",
    ),
    "passphraseMinLength": m3,
    "passphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Las frases de contraseña no coinciden",
    ),
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
    "recoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "He escrito mi código de recuperación",
    ),
    "recoveryCodeCopiedToast": MessageLookupByLibrary.simpleMessage(
      "Código de recuperación copiado",
    ),
    "recoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Escribe esto y guárdalo en un lugar seguro. Es la ÚNICA forma de recuperar tus notas si olvidas la frase de contraseña. No se volverá a mostrar.",
    ),
    "regenerateButton": MessageLookupByLibrary.simpleMessage("Regenerar"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Regenerar código de recuperación",
    ),
    "regenerateRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Esto invalida tu antiguo código de recuperación. Introduce tu contraseña para continuar.",
    ),
    "reminderRemoved": MessageLookupByLibrary.simpleMessage(
      "Recordatorio eliminado",
    ),
    "reminderSchedulingFailed": MessageLookupByLibrary.simpleMessage(
      "No se ha podido programar el recordatorio. Inténtalo de nuevo.",
    ),
    "reminderSet": MessageLookupByLibrary.simpleMessage(
      "Recordatorio establecido",
    ),
    "reminderTimeMustBeInFuture": MessageLookupByLibrary.simpleMessage(
      "Por favor, elija una hora en el futuro",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Recordatorios"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Eliminar cifrado de esta nota",
    ),
    "removeReminder": MessageLookupByLibrary.simpleMessage(
      "Quitar recordatorio",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Restablecer contraseña",
    ),
    "resetPin": MessageLookupByLibrary.simpleMessage("Restablecer el PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage(
      "¿Deseas aplicar el tema?",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Guardar cambios"),
    "searchInNoteHint": MessageLookupByLibrary.simpleMessage("Buscar en "),
    "security": MessageLookupByLibrary.simpleMessage("Seguridad"),
    "securityBackedUpNotes": MessageLookupByLibrary.simpleMessage("Respaldado"),
    "securityBackupNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Elija un proveedor de copia de seguridad en la nube para ver las estadísticas de copia de seguridad.",
    ),
    "securityBackupOffline": MessageLookupByLibrary.simpleMessage(
      "El estado de la copia de seguridad no está disponible sin conexión.",
    ),
    "securityBackupSetupHint": MessageLookupByLibrary.simpleMessage(
      "Habilite la copia de seguridad en la nube para que nunca pierda sus notas.",
    ),
    "securityBackupSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Configurar copia de seguridad",
    ),
    "securityBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Privacidad y copia de seguridad",
    ),
    "securityBackupUnverified": MessageLookupByLibrary.simpleMessage(
      "Sincroniza una vez para verificar el estado de tu copia de seguridad.",
    ),
    "securityEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Notas cifradas",
    ),
    "securityLastSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Última sincronización correcta",
    ),
    "securityLastSync": MessageLookupByLibrary.simpleMessage(
      "Última sincronización",
    ),
    "securityMetricUnavailable": MessageLookupByLibrary.simpleMessage(
      "No disponible",
    ),
    "securityNoSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Aún no se ha sincronizado correctamente.",
    ),
    "securityPendingBackup": MessageLookupByLibrary.simpleMessage(
      "Necesita copia de seguridad",
    ),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Configuraciones de seguridad",
    ),
    "securityStatsNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Aún no ha seleccionado una plataforma de copia de seguridad en la nube.",
    ),
    "securitySyncedData": MessageLookupByLibrary.simpleMessage(
      "Datos de la nube",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Seleccionar"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Seleccionar voz"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Enviar comentarios"),
    "setPassphrase": MessageLookupByLibrary.simpleMessage(
      "Frase de contraseña",
    ),
    "setTodoReminder": MessageLookupByLibrary.simpleMessage(
      "Establecer recordatorio de tareas pendientes",
    ),
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
    "syncSourceNone": MessageLookupByLibrary.simpleMessage("Ninguno"),
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
    "todoReminderNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Recordatorio de tareas pendientes",
    ),
    "todoRemindersNeedUncheckedTodo": MessageLookupByLibrary.simpleMessage(
      "Coloque el cursor en un elemento pendiente para establecer un recordatorio",
    ),
    "todoRemindersUnavailableInEncryptedNotes":
        MessageLookupByLibrary.simpleMessage(
          "Los recordatorios no están disponibles en notas cifradas",
        ),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Demasiados intentos incorrectos, por favor inicia sesión con contraseña",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "~Bloquear posición de la barra de herramientas",
    ),
    "toolbarPositionBottom": MessageLookupByLibrary.simpleMessage(
      "Parte inferior",
    ),
    "toolbarPositionTop": MessageLookupByLibrary.simpleMessage("Arriba"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Ocurrió un error inesperado",
    ),
    "unlockAction": MessageLookupByLibrary.simpleMessage("Desbloquear"),
    "unlockButton": MessageLookupByLibrary.simpleMessage("Desbloquear"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Desbloquear notas cifradas",
    ),
    "unlockNoteAction": MessageLookupByLibrary.simpleMessage(
      "Nota de desbloqueo",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Desbloquear esta nota",
    ),
    "usePassphraseInstead": MessageLookupByLibrary.simpleMessage(
      "Utiliza una frase de contraseña en su lugar",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "visitWebsite": MessageLookupByLibrary.simpleMessage(
      "Visita nuestra página web",
    ),
    "webdavURL": MessageLookupByLibrary.simpleMessage("URL de WebDAV"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Qué hay de nuevo"),
    "whatsNewCloudBackupSubtitle": MessageLookupByLibrary.simpleMessage(
      "Consulta qué notas están respaldadas, la carga pendiente y cuándo se realizó la última sincronización.",
    ),
    "whatsNewCloudBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Estado de copia de seguridad en la nube",
    ),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Proteja las notas confidenciales con opciones de cifrado y recuperación basadas en frases de contraseña.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Acerca del cifrado",
    ),
    "whatsNewHomeSearchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Busque notas en la página de inicio y busque dentro de una nota mientras lee.",
    ),
    "whatsNewHomeSearchTitle": MessageLookupByLibrary.simpleMessage(
      "Buscar en todas las secciones",
    ),
    "whatsNewStreakTrackingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Haz un seguimiento de tu racha actual, la racha más larga, el total de palabras y un mapa de calor de actividad de 6 meses.",
    ),
    "whatsNewStreakTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Rachas y estadísticas de escritura",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Personaliza DiaryVault con tus propios colores y estilo visual.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Creación y personalización de temas",
    ),
    "whatsNewTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Añade listas de verificación dentro de las notas, crea todos independientes y recibe notificaciones con recordatorios.",
    ),
    "whatsNewTodosTitle": MessageLookupByLibrary.simpleMessage(
      "Todos con recordatorios",
    ),
    "writingActivity": MessageLookupByLibrary.simpleMessage(
      "centrada en el significado.",
    ),
    "writingActivityEmpty": MessageLookupByLibrary.simpleMessage(
      "Tus días de escritura se mostrarán aquí.",
    ),
    "writingActivityLess": MessageLookupByLibrary.simpleMessage("Menos"),
    "writingActivityMore": MessageLookupByLibrary.simpleMessage("Más"),
    "writingActivityPeriod": MessageLookupByLibrary.simpleMessage(
      "Últimos 6 meses",
    ),
    "writingActivityPrivacyNote": MessageLookupByLibrary.simpleMessage(
      "Las notas cifradas no se incluyen en estas estadísticas.",
    ),
    "writingCurrentStreak": MessageLookupByLibrary.simpleMessage(
      "Racha actual",
    ),
    "writingDay": MessageLookupByLibrary.simpleMessage("día"),
    "writingDays": MessageLookupByLibrary.simpleMessage("días"),
    "writingLongestStreak": MessageLookupByLibrary.simpleMessage(
      "Racha más larga",
    ),
    "writingTotalWords": MessageLookupByLibrary.simpleMessage(
      "Total de palabras",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("PIN incorrecto"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Tienes cambios sin guardar",
    ),
    "youWillBeNotifiedAt": m4,
    "yourRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Tu código de recuperación",
    ),
  };
}
