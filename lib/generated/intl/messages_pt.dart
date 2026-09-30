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

  static String m3(minLength) =>
      "A senha deve ter pelo menos ${minLength} caracteres";

  static String m4(time) => "Você será notificado às ${time}";

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
    "backAction": MessageLookupByLibrary.simpleMessage("Voltar"),
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
    "changePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Mudar a frase-passe",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Alterar senha"),
    "changeReminderTime": MessageLookupByLibrary.simpleMessage(
      "Alterar hora do lembrete",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Escolha a imagem de fundo",
    ),
    "choosePassphraseHint": MessageLookupByLibrary.simpleMessage(
      "Introduza isto para desbloquear notas encriptadas. Use algo longo e memorável.",
    ),
    "choosePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Escolha uma frase secreta",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Escolha a fonte de sincronização",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Escolha um tema"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Escolha a hora"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("Deseja fechar o app?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("Backup na nuvem"),
    "confirmNewPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmar nova frase secreta",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmar nova senha",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Confirmar o novo PIN",
    ),
    "confirmPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmar nova frase secreta",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Continuar como convidado",
    ),
    "continueButton": MessageLookupByLibrary.simpleMessage("Continuar"),
    "copyButtonTooltip": MessageLookupByLibrary.simpleMessage("Copiar"),
    "create": MessageLookupByLibrary.simpleMessage("Criar"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("Crie o seu tema"),
    "currentPassphraseIncorrect": MessageLookupByLibrary.simpleMessage(
      "A frase-passe atual está incorreta",
    ),
    "currentPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      " Frase-passe atual",
    ),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Escolha uma foto que você goste ou escolha uma cor de fundo e criaremos um tema em torno dela.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage(
      "Temas Personalizados:",
    ),
    "dailyReminders": MessageLookupByLibrary.simpleMessage("Lembretes diários"),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Escuro"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Tema Escuro"),
    "dashboardAddTodo": MessageLookupByLibrary.simpleMessage(
      "Adicionar um todo",
    ),
    "dashboardAnotherPrompt": MessageLookupByLibrary.simpleMessage(
      "Outro prompt",
    ),
    "dashboardComingSoon": MessageLookupByLibrary.simpleMessage("Brevemente"),
    "dashboardCompletedTodos": MessageLookupByLibrary.simpleMessage(
      "Concluído",
    ),
    "dashboardCreateTodo": MessageLookupByLibrary.simpleMessage("Add"),
    "dashboardDailyPrompt": MessageLookupByLibrary.simpleMessage(
      "Solicitação diária",
    ),
    "dashboardDailyPrompt1": MessageLookupByLibrary.simpleMessage(
      "O que pareceu uma pequena vitória para mim hoje?",
    ),
    "dashboardDailyPrompt2": MessageLookupByLibrary.simpleMessage(
      "De que momento a partir de hoje eu quero me lembrar?",
    ),
    "dashboardDailyPrompt3": MessageLookupByLibrary.simpleMessage(
      "O que exigiu mais energia do que eu esperava hoje?",
    ),
    "dashboardDailyPrompt4": MessageLookupByLibrary.simpleMessage(
      "O que posso deixar de lado esta noite?",
    ),
    "dashboardDailyPrompt5": MessageLookupByLibrary.simpleMessage(
      "O que aprendi sobre mim hoje?",
    ),
    "dashboardDailyPrompt6": MessageLookupByLibrary.simpleMessage(
      "O que tornou o meu dia um pouco mais fácil?",
    ),
    "dashboardDailyPrompt7": MessageLookupByLibrary.simpleMessage(
      "O que faria o amanhã parecer mais gentil para mim?",
    ),
    "dashboardDailyPrompt8": MessageLookupByLibrary.simpleMessage(
      "O que me fez sentir grato hoje?",
    ),
    "dashboardDueToday": MessageLookupByLibrary.simpleMessage(
      "Data-limite para hoje",
    ),
    "dashboardEditTodo": MessageLookupByLibrary.simpleMessage("Editar tarefa"),
    "dashboardMoodCheckIn": MessageLookupByLibrary.simpleMessage(
      "Registo (Acompanhamento)",
    ),
    "dashboardMoodContextPrompt": MessageLookupByLibrary.simpleMessage(
      "Quer adicionar um pouco de contexto?",
    ),
    "dashboardMoodDifficult": MessageLookupByLibrary.simpleMessage(
      "Tendo um dia difícil",
    ),
    "dashboardMoodGood": MessageLookupByLibrary.simpleMessage("Bom"),
    "dashboardMoodGreat": MessageLookupByLibrary.simpleMessage("Excelente"),
    "dashboardMoodLow": MessageLookupByLibrary.simpleMessage("Não muito bem"),
    "dashboardMoodNoteTitle": MessageLookupByLibrary.simpleMessage(
      "Reflexão de hoje",
    ),
    "dashboardMoodOkay": MessageLookupByLibrary.simpleMessage("Ok"),
    "dashboardMoodOpeningDifficult": MessageLookupByLibrary.simpleMessage(
      "Hoje foi um dia difícil.",
    ),
    "dashboardMoodOpeningGood": MessageLookupByLibrary.simpleMessage(
      "Hoje, sinto-me bem.",
    ),
    "dashboardMoodOpeningGreat": MessageLookupByLibrary.simpleMessage(
      "Hoje, sinto-me muito bem.",
    ),
    "dashboardMoodOpeningLow": MessageLookupByLibrary.simpleMessage(
      "Não me sinto muito bem.",
    ),
    "dashboardMoodOpeningOkay": MessageLookupByLibrary.simpleMessage(
      "Hoje, estou bem.",
    ),
    "dashboardMoodReflectionHint": MessageLookupByLibrary.simpleMessage(
      "Tem mais alguma coisa em mente? (opcional)",
    ),
    "dashboardMoodSaveToJournal": MessageLookupByLibrary.simpleMessage(
      "Adicionar à nota de hoje",
    ),
    "dashboardMoodSubtitle": MessageLookupByLibrary.simpleMessage(
      "Como se sente hoje?",
    ),
    "dashboardNoDueDate": MessageLookupByLibrary.simpleMessage(
      "Sem data- limiteexcept for listed dates",
    ),
    "dashboardNoTodos": MessageLookupByLibrary.simpleMessage(
      "Ainda não há todos aqui",
    ),
    "dashboardNoTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "As suas tarefas abertas e concluídas aparecerão aqui.",
    ),
    "dashboardOpenInNote": MessageLookupByLibrary.simpleMessage(
      "Abrir na nota",
    ),
    "dashboardOpenTodos": MessageLookupByLibrary.simpleMessage("Transparente"),
    "dashboardOverdue": MessageLookupByLibrary.simpleMessage("Vencido"),
    "dashboardPromptSubtitle": MessageLookupByLibrary.simpleMessage(
      "Uma pequena pergunta para refletir",
    ),
    "dashboardQuickCapture": MessageLookupByLibrary.simpleMessage(
      "Captura Rápida",
    ),
    "dashboardReminderOptional": MessageLookupByLibrary.simpleMessage(
      "Sem lembrete",
    ),
    "dashboardSaveTodo": MessageLookupByLibrary.simpleMessage("Salvar"),
    "dashboardToday": MessageLookupByLibrary.simpleMessage("Hoje"),
    "dashboardTodoLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Não foi possível carregar todos",
    ),
    "dashboardTodoRequired": MessageLookupByLibrary.simpleMessage(
      "Insira um todo primeiro",
    ),
    "dashboardTodoSourceHint": MessageLookupByLibrary.simpleMessage(
      "Todos podem ser adicionados a partir de uma nota ou criados diretamente aqui.",
    ),
    "dashboardTodoTitle": MessageLookupByLibrary.simpleMessage(
      "O que precisa ser feito?",
    ),
    "dashboardTodoUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Não foi possível atualizar este todo",
    ),
    "dashboardTodos": MessageLookupByLibrary.simpleMessage("Todos"),
    "dashboardUpcoming": MessageLookupByLibrary.simpleMessage("Próximas"),
    "dashboardWriteAboutPrompt": MessageLookupByLibrary.simpleMessage(
      "Escrever sobre isto",
    ),
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
    "editorPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Escreva algo aqui",
    ),
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
    "encryptYourNotesDescription": MessageLookupByLibrary.simpleMessage(
      "As notas que marcar como encriptadas estão protegidas neste dispositivo e na sua cópia de segurança na nuvem com uma frase secreta que só você conhece. Ninguém mais - incluindo nós e o seu fornecedor de nuvem - pode lê-los.",
    ),
    "encryptYourNotesTitle": MessageLookupByLibrary.simpleMessage(
      "Encripte as suas notas",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage("Notas encriptadas"),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "As notas encriptadas estão bloqueadas",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Encriptação"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Ativado"),
    "encryptionEnabledToast": MessageLookupByLibrary.simpleMessage(
      "Encriptação ativada",
    ),
    "encryptionLossAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Entendo que não há como recuperar minhas anotações se eu esquecer esta frase secreta e perder o código de recuperação",
    ),
    "encryptionLossWarning": MessageLookupByLibrary.simpleMessage(
      "⚠️ Se você esquecer a senha E perder o código de recuperação, as anotações criptografadas desaparecerão para sempre. Não há como recuperá-los.",
    ),
    "encryptionSeparateViewDescription": MessageLookupByLibrary.simpleMessage(
      "As notas encriptadas ficam numa vista bloqueada separada e são excluídas da pesquisa.",
    ),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Configurar uma frase secreta e um código de recuperação",
    ),
    "encryptionStaysOnToast": MessageLookupByLibrary.simpleMessage(
      "A encriptação permanece ativada para notas encriptadas. Bloqueie-os a qualquer momento a partir da visualização de anotações criptografadas.",
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
    "forgotPassphraseUseRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Esqueceu a frase secreta? Use o código de recuperação",
    ),
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
    "lockAction": MessageLookupByLibrary.simpleMessage("Bloqueio"),
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
    "newPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Nova frase secreta",
    ),
    "newPassphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "As senhas não conferem.\n",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nova senha"),
    "newRecoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Eu escrevi o novo código",
    ),
    "newRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Anote-o e guarde-o em segurança. Não será mostrado novamente.",
    ),
    "newRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Código de recuperação",
    ),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Ainda não há notas encriptadas",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Indisponível"),
    "notNow": MessageLookupByLibrary.simpleMessage("Agora não"),
    "noteCollapsePreview": MessageLookupByLibrary.simpleMessage(
      "Recolher pré-visualização",
    ),
    "noteDifferentPassphrase": MessageLookupByLibrary.simpleMessage(
      "Esta nota está protegida por uma frase secreta diferente",
    ),
    "noteExpandPreview": MessageLookupByLibrary.simpleMessage(
      "Expandir pré-visualização",
    ),
    "noteNoTitle": MessageLookupByLibrary.simpleMessage("Nota sem título"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Anotação salva com sucesso",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Anotação atualizada com sucesso",
    ),
    "noteWillBeSavedEncrypted": MessageLookupByLibrary.simpleMessage(
      "A nota será guardada encriptada",
    ),
    "noteWillBeSavedUnencrypted": MessageLookupByLibrary.simpleMessage(
      "A nota será guardada sem encriptação",
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
    "passphraseLabel": MessageLookupByLibrary.simpleMessage("Frase- senha"),
    "passphraseMinLength": m3,
    "passphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "As senhas não conferem.\n",
    ),
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
    "recoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Anotei o meu código de recuperação",
    ),
    "recoveryCodeCopiedToast": MessageLookupByLibrary.simpleMessage(
      "Código de recuperação copiado",
    ),
    "recoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Escreva isto e guarde-o num local seguro. É a ÚNICA maneira de recuperar as suas notas se se esquecer da frase secreta. Não será mostrado novamente.",
    ),
    "regenerateButton": MessageLookupByLibrary.simpleMessage("Regenerar"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Regenerar código de recuperação",
    ),
    "regenerateRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Isso invalida o seu código de recuperação antigo. Introduza a sua frase secreta para continuar.",
    ),
    "reminderRemoved": MessageLookupByLibrary.simpleMessage(
      "Lembrete removido",
    ),
    "reminderSchedulingFailed": MessageLookupByLibrary.simpleMessage(
      "Não foi possível agendar o lembrete. Tente novamente.",
    ),
    "reminderSet": MessageLookupByLibrary.simpleMessage("Aviso Programado"),
    "reminderTimeMustBeInFuture": MessageLookupByLibrary.simpleMessage(
      "Escolha um horário no futuro",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Lembretes"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Remover encriptação desta nota",
    ),
    "removeReminder": MessageLookupByLibrary.simpleMessage("Remover lembrete"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Resetar senhar"),
    "resetPin": MessageLookupByLibrary.simpleMessage("Redefinir PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage("Aplicar tema"),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Guardar as alterações",
    ),
    "searchInNoteHint": MessageLookupByLibrary.simpleMessage("Pesquisar em"),
    "security": MessageLookupByLibrary.simpleMessage("Segurança"),
    "securityBackedUpNotes": MessageLookupByLibrary.simpleMessage(
      "Com cópia de segurança ",
    ),
    "securityBackupNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Escolha um fornecedor de backup na nuvem para ver as estatísticas de backup.",
    ),
    "securityBackupOffline": MessageLookupByLibrary.simpleMessage(
      "O estado da cópia de segurança não está disponível offline.",
    ),
    "securityBackupSetupHint": MessageLookupByLibrary.simpleMessage(
      "Ative a cópia de segurança na nuvem para nunca perder as suas notas.",
    ),
    "securityBackupSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Configurar backup",
    ),
    "securityBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Privacidade e backup",
    ),
    "securityBackupUnverified": MessageLookupByLibrary.simpleMessage(
      "Sincronize uma vez para verificar o estado da cópia de segurança.",
    ),
    "securityEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Notas encriptadas",
    ),
    "securityLastSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Última sincronização bem-sucedida",
    ),
    "securityLastSync": MessageLookupByLibrary.simpleMessage(
      "Última sincronização",
    ),
    "securityMetricUnavailable": MessageLookupByLibrary.simpleMessage(
      "Indisponível",
    ),
    "securityNoSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Nenhuma sincronização bem-sucedida ainda.",
    ),
    "securityPendingBackup": MessageLookupByLibrary.simpleMessage(
      "Precisa de backup",
    ),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Configurações de segurança",
    ),
    "securityStatsNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Ainda não selecionou uma plataforma de backup na nuvem.",
    ),
    "securitySyncedData": MessageLookupByLibrary.simpleMessage(
      "Dados na nuvem",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Selecione"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Escolha a voz:"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Mande um feedback"),
    "setPassphrase": MessageLookupByLibrary.simpleMessage(
      "Definir frase secreta",
    ),
    "setTodoReminder": MessageLookupByLibrary.simpleMessage(
      "Definir lembrete de tarefas pendentes",
    ),
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
    "syncSourceNone": MessageLookupByLibrary.simpleMessage("Nenhuma"),
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
    "todoReminderNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Lembrete de tarefas pendentes",
    ),
    "todoRemindersNeedUncheckedTodo": MessageLookupByLibrary.simpleMessage(
      "Coloque o cursor num item por-fazer para definir um lembrete",
    ),
    "todoRemindersUnavailableInEncryptedNotes":
        MessageLookupByLibrary.simpleMessage(
          "Os lembretes não estão disponíveis em notas encriptadas",
        ),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Muitas tentativas incorretas, tente o login utilizando a senha",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Bloquear posi~ção da barra de ferramentas",
    ),
    "toolbarPositionBottom": MessageLookupByLibrary.simpleMessage("Base"),
    "toolbarPositionTop": MessageLookupByLibrary.simpleMessage("Topo"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro inesperado",
    ),
    "unlockAction": MessageLookupByLibrary.simpleMessage("Desbloquear"),
    "unlockButton": MessageLookupByLibrary.simpleMessage("Desbloquear"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Desbloquear notas encriptadas",
    ),
    "unlockNoteAction": MessageLookupByLibrary.simpleMessage(
      "Desbloquear nota",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Desbloquear esta nota",
    ),
    "usePassphraseInstead": MessageLookupByLibrary.simpleMessage(
      "Em vez disso, use a frase secreta",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Vídeo"),
    "visitWebsite": MessageLookupByLibrary.simpleMessage("Visite o nosso site"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("URL do WebDAV"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Novidades"),
    "whatsNewCloudBackupSubtitle": MessageLookupByLibrary.simpleMessage(
      "Veja quais anotações estão em backup, o envio pendente e quando ocorreu a última sincronização.",
    ),
    "whatsNewCloudBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Estado da cópia de segurança na nuvem",
    ),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Proteja notas confidenciais com opções de criptografia e recuperação baseadas em senha.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Sobre encriptação",
    ),
    "whatsNewHomeSearchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Encontre notas na página inicial e pesquise dentro de uma nota durante a leitura.",
    ),
    "whatsNewHomeSearchTitle": MessageLookupByLibrary.simpleMessage(
      "Veja em todos os lugares.",
    ),
    "whatsNewStreakTrackingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Acompanhe a sua sequência atual, a sequência mais longa, o total de palavras e um mapa de calor de atividades de 6 meses.",
    ),
    "whatsNewStreakTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Riscas e estatísticas de escrita",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Personalize o DiaryVault com as suas próprias cores e estilo visual.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Criação e personalização de temas",
    ),
    "whatsNewTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Adicione listas de verificação dentro das notas, crie todos independentes e seja notificado com lembretes.",
    ),
    "whatsNewTodosTitle": MessageLookupByLibrary.simpleMessage(
      "Todos com lembretes",
    ),
    "writingActivity": MessageLookupByLibrary.simpleMessage(
      "Atividade de Redação",
    ),
    "writingActivityEmpty": MessageLookupByLibrary.simpleMessage(
      "Os seus dias de escrita serão mostrados aqui.",
    ),
    "writingActivityLess": MessageLookupByLibrary.simpleMessage("Menos"),
    "writingActivityMore": MessageLookupByLibrary.simpleMessage("Mais"),
    "writingActivityPeriod": MessageLookupByLibrary.simpleMessage(
      "Últimos 6 meses",
    ),
    "writingActivityPrivacyNote": MessageLookupByLibrary.simpleMessage(
      "As anotações criptografadas não estão incluídas nessas estatísticas.",
    ),
    "writingCurrentStreak": MessageLookupByLibrary.simpleMessage(
      "Sequência atual",
    ),
    "writingDay": MessageLookupByLibrary.simpleMessage("dia..."),
    "writingDays": MessageLookupByLibrary.simpleMessage("dias"),
    "writingLongestStreak": MessageLookupByLibrary.simpleMessage(
      "A maior sequência de vitórias:",
    ),
    "writingTotalWords": MessageLookupByLibrary.simpleMessage(
      "Total de palavras:",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("PIN errado"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Você possui alterações não salvas",
    ),
    "youWillBeNotifiedAt": m4,
    "yourRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Código de recuperação",
    ),
  };
}
