// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(imported, skipped, failed) =>
      "Notas importadas ${imported}, ignoradas ${skipped} existentes, ${failed} falhou";

  static String m1(imported, skipped) =>
      "Notas importadas ${imported}, ignoradas ${skipped} notas existentes";

  static String m2(count) => "${count} notas importadas";

  static String m3(time) => "Você será notificado às ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Destaque"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Conta configurada com sucesso",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Já possui uma conta?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Discover diaryVault - um aplicativo de diário feito para te ajudar a salvar seus pensamentos, suas memórias e seus momentos sem maiores esforços. Disponível agora na Play Store!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("Idioma do aplicativo"),
    "appVersion": MessageLookupByLibrary.simpleMessage("Versão do app"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "Deseja sair do aplicativo?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage(
      "Sincronizar automaticamente",
    ),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Salva automaticamente suas anotações a cada 10 segundos",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Sincronizar anotações para a nuvem automaticamente",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Plataformas disponíveis para sincronização",
    ),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "Ao clicar em prosseguir você concorda com nossas ",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Câmera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "change": MessageLookupByLibrary.simpleMessage("Mudar"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Modificar cor do plano de fundo",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage("Alterar email"),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Alterar frase secreta de encriptação",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Alterar imagem"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Alterar senha"),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Escolha a imagem de fundo",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Escolha a fonte de sincronização",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Escolha um tema"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Escolha a hora"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("Deseja fechar o app?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("Backup na nuvem"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmar nova senha",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Confirmar o novo PIN",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Continuar como convidado",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Criar"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("Crie o seu tema"),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Escolha uma foto que você goste ou escolha uma cor de fundo e criaremos um tema em torno dela.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage(
      "Temas Personalizados:",
    ),
    "dailyReminders": MessageLookupByLibrary.simpleMessage("Lembretes diários"),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Escuro"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Tema Escuro"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Filtro por data"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Temas próprios"),
    "delete": MessageLookupByLibrary.simpleMessage("Excluir"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage("Falha ao deletar"),
    "done": MessageLookupByLibrary.simpleMessage("Pronto"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Não possui uma conta?",
    ),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Editar Tema"),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Email atualizado com sucesso, faça o login novamente",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage(
      "Habilitar salvamento automático",
    ),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Ativar lembretes diários",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Habilitar login por biometria",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Ativar encriptação de notas",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "Ativar início DE sessão com PIN",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Criptografe notas confidenciais com uma frase secreta que só você conhece. As notas encriptadas são protegidas neste dispositivo e na sua cópia de segurança na nuvem e ficam numa vista bloqueada separada.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage(
      "Criptografar esta nota",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage("Notas encriptadas"),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "As notas encriptadas estão bloqueadas",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Encriptação"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Ativado"),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Configurar uma frase secreta e um código de recuperação",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Insira a senha atual",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage(
      "Insira um novo email",
    ),
    "enterPin": MessageLookupByLibrary.simpleMessage("Insira seu PIN"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Insira o email cadastrado",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Exporte suas notas"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("Exportar para JSON"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage("Exportar para PDF"),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Exportar para texto simples",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage(
      "Falha ao buscar anotação",
    ),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage(
      "Falha ao salvar anotação",
    ),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "O login por biometria deve ser habilitado nas configurações do dispositivo",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Falha no login por biometria",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Tipo de Letra"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Esqueci minha senha",
    ),
    "from": MessageLookupByLibrary.simpleMessage("De"),
    "gallery": MessageLookupByLibrary.simpleMessage("Galeria"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Receba lembretes diários no horário escolhido para manter seu diário atualizado.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Importar e Exportar Notas",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("importado de"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Palavra-passe incorreta",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Senha incorreta",
    ),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Código de recuperação incorreto.",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Ficheiro de cópia de segurança inválido",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Português - Brasil"),
    "lastSynced": MessageLookupByLibrary.simpleMessage(
      "Última sincronização: ",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("Deixar"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Luz"),
    "link": MessageLookupByLibrary.simpleMessage("Ligação"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Bloquear notas encriptadas",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("Bloquear esta nota"),
    "logIn": MessageLookupByLibrary.simpleMessage("Login"),
    "logOut": MessageLookupByLibrary.simpleMessage("Sair"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Sair"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Faça o login para habilitar a sincronização automática",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("Mais informações"),
    "muted": MessageLookupByLibrary.simpleMessage("Esbatido"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nova senha"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Ainda não há notas encriptadas",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Indisponível"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Anotação salva com sucesso",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Anotação atualizada com sucesso",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Anotações sincronizadas com sucesso",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Reserve alguns minutos para refletir sobre o seu dia em seu diário",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Você não selecionou um horário de notificação",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "Hora de registrar no diário!",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "As notificações não estão ativadas",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage(
      "Página não encontrada",
    ),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Paleta (toque numa amostra para editar)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Frase- senha"),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "Email para recuperação de senha enviado",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Senha alterada com sucesso",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Senha verificada",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "As senhas não são iguais",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Escolha uma cor"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Em vez disso, escolha uma cor de fundo",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage(
      "Escolher a partir de ficheiros",
    ),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Falha ao iniciar sessão",
    ),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "Um PIN de até 4 dígitos será solicitado na tela de bloqueio",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Introduza um ano com 4 dígitos",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Sensação DE confirmação do PIN",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Os PINs não correspondem",
    ),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage(
          "Por favor, configure sua conta para usar essa funcionalidade",
        ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Políticas de privacidade",
    ),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage(
      "Visite nosso projeto no Github",
    ),
    "recordAudio": MessageLookupByLibrary.simpleMessage("הקלט אודיו"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage(
      "Código de recuperação",
    ),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Regenerar código de recuperação",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Lembretes"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Remover encriptação desta nota",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Resetar senhar"),
    "resetPin": MessageLookupByLibrary.simpleMessage("Redefinir PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage("Aplicar tema"),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Guardar as alterações",
    ),
    "security": MessageLookupByLibrary.simpleMessage("Segurança"),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Configurações de segurança",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Selecione"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Escolha a voz:"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Mande um feedback"),
    "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage(
      "Configure sua conta",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Compartilhe o app com seus amigos",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Entrar"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "Iniciar sessão com o e-mail",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Cadastre-se"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Logado como"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage("Classificar por A-Z"),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "Classificar por mais recente primeiro",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "Classificar por mais antigo primeiro",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("Ficar"),
    "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Sincronizar"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "A etiqueta já existe",
    ),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Clique aqui para expandir o título",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Customize Tema, Fontes e Idioma",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Nome do tema pai"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Temas próprios"),
    "to": MessageLookupByLibrary.simpleMessage("Para"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Muitas tentativas incorretas, tente o login utilizando a senha",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Bloquear posi~ção da barra de ferramentas",
    ),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro inesperado",
    ),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Desbloquear notas encriptadas",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Desbloquear esta nota",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Vídeo"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("URL do WebDAV"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Novidades"),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Proteja notas confidenciais com opções de criptografia e recuperação baseadas em senha.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Sobre encriptação",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Personalize o DiaryVault com as suas próprias cores e estilo visual.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Criação e personalização de temas",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("PIN errado"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Você possui alterações não salvas",
    ),
    "youWillBeNotifiedAt": m3,
  };
}
