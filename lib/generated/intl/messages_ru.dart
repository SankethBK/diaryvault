// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(imported, skipped, failed) =>
      "Импортировано ${imported} заметок, пропущено ${skipped} существующих, ${failed} не удалось";

  static String m1(imported, skipped) =>
      "Импортировано ${imported} заметок, пропущено ${skipped} существующих заметок";

  static String m2(count) => "Импортировано ${count} заметок";

  static String m3(minLength) =>
      "Парольная фраза должна содержать не менее ${minLength} символов";

  static String m4(time) => "Вы получите уведомление в ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Акцент"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Настройка аккаунта прошла успешно",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "У вас уже есть учетная запись?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Discover diaryVault - приложение для ведения дневника, которое поможет вам легко запечатлеть свои мысли, воспоминания и моменты. Уже доступно в Play Маркете!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("Язык Приложения"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Мои молочные продукты"),
    "appVersion": MessageLookupByLibrary.simpleMessage("Версия приложения"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите выйти?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage("Автосинхронизация"),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Автоматически сохраняет заметки каждые 10 секунд",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Автоматическая синхронизация заметок с облаком",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Доступные платформы для синхронизации",
    ),
    "backAction": MessageLookupByLibrary.simpleMessage("Назад"),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "Продолжая, вы принимаете наши",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Камера"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "change": MessageLookupByLibrary.simpleMessage("Изменение"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Изменить цвет фона",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage(
      "Изменить адрес электронной почты",
    ),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Изменить парольную фразу шифрования",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Изменить изображение"),
    "changePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Изменить парольную фразу",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Смена пароля"),
    "changeReminderTime": MessageLookupByLibrary.simpleMessage(
      "Изменить напоминание",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Выберите фоновое изображение",
    ),
    "choosePassphraseHint": MessageLookupByLibrary.simpleMessage(
      "Введите это, чтобы разблокировать зашифрованные заметки. Используйте что-то длинное и запоминающееся.",
    ),
    "choosePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Выберите парольную фразу",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Выбор источника синхронизации",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Выберите тему"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Выберите время"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("Закрыть приложение?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage(
      "Удалённое резервное копирование данных",
    ),
    "confirmNewPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Подтвердите новую парольную фразу",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Подтвердите новый пароль",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Подтвердите новый ПИН-код",
    ),
    "confirmPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Подтвердите кодовую фразу",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Продолжить В Качестве Гостя",
    ),
    "continueButton": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "copyButtonTooltip": MessageLookupByLibrary.simpleMessage("Скопировать"),
    "create": MessageLookupByLibrary.simpleMessage("Создать"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage(
      "Создать свою собственную тему",
    ),
    "currentPassphraseIncorrect": MessageLookupByLibrary.simpleMessage(
      "Текущая парольная фраза неверна",
    ),
    "currentPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Текущая парольная фраза",
    ),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Выберите понравившуюся фотографию или цвет фона, и мы создадим вокруг нее тему.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage(
      "Пользовательская Теми",
    ),
    "dailyReminders": MessageLookupByLibrary.simpleMessage(
      "Щоденні нагадування",
    ),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Темный"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Темная тема"),
    "dashboardAddTodo": MessageLookupByLibrary.simpleMessage("Добавить задачу"),
    "dashboardAnotherPrompt": MessageLookupByLibrary.simpleMessage(
      "ДРУГАЯ ПОДСКАЗКА",
    ),
    "dashboardComingSoon": MessageLookupByLibrary.simpleMessage("Уже скоро"),
    "dashboardCompletedTodos": MessageLookupByLibrary.simpleMessage(
      "Завершено",
    ),
    "dashboardCreateTodo": MessageLookupByLibrary.simpleMessage("Добавить"),
    "dashboardDailyPrompt": MessageLookupByLibrary.simpleMessage(
      "Ежедневная подсказка",
    ),
    "dashboardDailyPrompt1": MessageLookupByLibrary.simpleMessage(
      "Что показалось мне сегодня маленькой победой?",
    ),
    "dashboardDailyPrompt2": MessageLookupByLibrary.simpleMessage(
      "Какой момент с сегодняшнего дня я хочу запомнить?",
    ),
    "dashboardDailyPrompt3": MessageLookupByLibrary.simpleMessage(
      "Что потребовало больше энергии, чем я ожидал сегодня?",
    ),
    "dashboardDailyPrompt4": MessageLookupByLibrary.simpleMessage(
      "От чего я могу избавиться сегодня вечером?",
    ),
    "dashboardDailyPrompt5": MessageLookupByLibrary.simpleMessage(
      "Что я узнал о себе сегодня?",
    ),
    "dashboardDailyPrompt6": MessageLookupByLibrary.simpleMessage(
      "Что сделало мой день немного легче?",
    ),
    "dashboardDailyPrompt7": MessageLookupByLibrary.simpleMessage(
      "Что сделает завтрашний день более мягким для меня?",
    ),
    "dashboardDailyPrompt8": MessageLookupByLibrary.simpleMessage(
      "Что заставило меня почувствовать благодарность сегодня?",
    ),
    "dashboardDueToday": MessageLookupByLibrary.simpleMessage(
      "Для выполнения сегодня",
    ),
    "dashboardEditTodo": MessageLookupByLibrary.simpleMessage(
      "Редактировать список дел",
    ),
    "dashboardMoodCheckIn": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "dashboardMoodContextPrompt": MessageLookupByLibrary.simpleMessage(
      "Хотите добавить немного контекста?",
    ),
    "dashboardMoodDifficult": MessageLookupByLibrary.simpleMessage(
      "Тяжелый день",
    ),
    "dashboardMoodGood": MessageLookupByLibrary.simpleMessage("Хорошо"),
    "dashboardMoodGreat": MessageLookupByLibrary.simpleMessage("Великолепно!"),
    "dashboardMoodLow": MessageLookupByLibrary.simpleMessage("Дела не очень."),
    "dashboardMoodNoteTitle": MessageLookupByLibrary.simpleMessage(
      "Сегодняшнее размышление",
    ),
    "dashboardMoodOkay": MessageLookupByLibrary.simpleMessage("Ладно"),
    "dashboardMoodOpeningDifficult": MessageLookupByLibrary.simpleMessage(
      "Сегодня был тяжелый день.",
    ),
    "dashboardMoodOpeningGood": MessageLookupByLibrary.simpleMessage(
      "Сегодня я чувствую себя хорошо.",
    ),
    "dashboardMoodOpeningGreat": MessageLookupByLibrary.simpleMessage(
      "Сегодня я чувствую себя отлично.",
    ),
    "dashboardMoodOpeningLow": MessageLookupByLibrary.simpleMessage(
      "Сегодня я неважно себя чувствую.",
    ),
    "dashboardMoodOpeningOkay": MessageLookupByLibrary.simpleMessage(
      "Сегодня я чувствую себя хорошо.",
    ),
    "dashboardMoodReflectionHint": MessageLookupByLibrary.simpleMessage(
      "Что-нибудь еще на уме? (необязательно)",
    ),
    "dashboardMoodSaveToJournal": MessageLookupByLibrary.simpleMessage(
      "Добавить к сегодняшней заметке",
    ),
    "dashboardMoodSubtitle": MessageLookupByLibrary.simpleMessage(
      "*Are You a Catch? *How Hot Are You?",
    ),
    "dashboardNoDueDate": MessageLookupByLibrary.simpleMessage(
      "Конечная дата не указана",
    ),
    "dashboardNoTodos": MessageLookupByLibrary.simpleMessage(
      "Тодо здесь пока нет",
    ),
    "dashboardNoTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Здесь будут отображаться ваши открытые и завершенные задачи.",
    ),
    "dashboardOpenInNote": MessageLookupByLibrary.simpleMessage(
      "Открыть в заметке",
    ),
    "dashboardOpenTodos": MessageLookupByLibrary.simpleMessage("Открыть"),
    "dashboardOverdue": MessageLookupByLibrary.simpleMessage("Просроченные"),
    "dashboardPromptSubtitle": MessageLookupByLibrary.simpleMessage(
      "Небольшой вопрос для размышления",
    ),
    "dashboardQuickCapture": MessageLookupByLibrary.simpleMessage(
      "Быстрый захват",
    ),
    "dashboardReminderOptional": MessageLookupByLibrary.simpleMessage(
      "Без напоминания",
    ),
    "dashboardSaveTodo": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "dashboardToday": MessageLookupByLibrary.simpleMessage("За сегодня"),
    "dashboardTodoLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить список задач",
    ),
    "dashboardTodoRequired": MessageLookupByLibrary.simpleMessage(
      "Сначала введите список дел",
    ),
    "dashboardTodoSourceHint": MessageLookupByLibrary.simpleMessage(
      "Тодо можно добавить из заметки или создать прямо здесь.",
    ),
    "dashboardTodoTitle": MessageLookupByLibrary.simpleMessage(
      "Что необходимо сделать?",
    ),
    "dashboardTodoUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось обновить это задание",
    ),
    "dashboardTodos": MessageLookupByLibrary.simpleMessage("Все"),
    "dashboardUpcoming": MessageLookupByLibrary.simpleMessage("Предстоящие"),
    "dashboardWriteAboutPrompt": MessageLookupByLibrary.simpleMessage(
      "Напишите об этом",
    ),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Фильтр по дате"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Моя тема"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Готово"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Нет учетной записи?",
    ),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Редактировать тему"),
    "editorPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Напишите что-нибудь…",
    ),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Электронная почта успешно обновлена, пожалуйста, войдите снова",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage("Включить"),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Включить ежедневные напоминания",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Включить вход по отпечатку пальца",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Включить шифрование заметок",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "Включить PIN-КОД для входа",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Шифруйте конфиденциальные заметки парольной фразой, которую знаете только вы. Зашифрованные заметки защищены на этом устройстве и в вашей облачной резервной копии и находятся в отдельном заблокированном представлении.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage(
      "Зашифровать это примечание",
    ),
    "encryptYourNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Заметки, которые вы отмечаете как зашифрованные, защищены на этом устройстве и в вашей облачной резервной копии парольной фразой, которую вы знаете. Никто другой, включая нас и вашего облачного провайдера, не может их прочитать.",
    ),
    "encryptYourNotesTitle": MessageLookupByLibrary.simpleMessage(
      "Зашифруйте заметки",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Зашифрованные заметки",
    ),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Зашифрованные заметки заблокированы",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Шифрование"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Включен"),
    "encryptionEnabledToast": MessageLookupByLibrary.simpleMessage(
      "Шифрование включено",
    ),
    "encryptionLossAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Я понимаю, что нет способа восстановить мои заметки, если я забуду эту парольную фразу и потеряю код восстановления",
    ),
    "encryptionLossWarning": MessageLookupByLibrary.simpleMessage(
      "⚠️ Если вы забудете пароль И потеряете код восстановления, зашифрованные заметки исчезнут навсегда. Восстановить их невозможно.",
    ),
    "encryptionSeparateViewDescription": MessageLookupByLibrary.simpleMessage(
      "Зашифрованные заметки находятся в отдельном заблокированном представлении и исключаются из поиска.",
    ),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Настройте парольную фразу и код восстановления",
    ),
    "encryptionStaysOnToast": MessageLookupByLibrary.simpleMessage(
      "Шифрование остается включенным для зашифрованных заметок. Блокируйте их в любое время из зашифрованного представления заметок.",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Ввести текущий пароль",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage(
      "Введите новый email",
    ),
    "enterPin": MessageLookupByLibrary.simpleMessage("Введите PIN-код"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Введите свой зарегистрированный адрес электронной почты",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage(
      "Экспортировать заметки",
    ),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("Экспорт в JSON"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage("Экспорт в PDF"),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Экспорт в обычный текст",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить примечание",
    ),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage("Сбой сохранения"),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "Аутентификация по отпечатку пальца должна быть включена в настройках устройства",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Ошибка входа по отпечатку пальца",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Шрифт"),
    "forgotPassphraseUseRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Забыли пароль? Используйте код восстановления",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "from": MessageLookupByLibrary.simpleMessage("От"),
    "gallery": MessageLookupByLibrary.simpleMessage("Галерея"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Получайте ежедневные напоминания в выбранное время, чтобы поддерживать свой журнал в актуальном состоянии.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Примечания по импорту и экспорту",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage(
      "Импорт из JSON файла",
    ),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Неверная парольная фраза",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Неверный пароль",
    ),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Неверный код восстановления",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Неверный файл резервной копии.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Russian"),
    "lastSynced": MessageLookupByLibrary.simpleMessage(
      "Последняя синхронизация: %@",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("Выйти"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Легкий"),
    "link": MessageLookupByLibrary.simpleMessage("Ссылки"),
    "lockAction": MessageLookupByLibrary.simpleMessage("Замок."),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Блокировка зашифрованных заметок",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage(
      "Заблокировать эту заметку",
    ),
    "logIn": MessageLookupByLibrary.simpleMessage("Войти в личный кабинет"),
    "logOut": MessageLookupByLibrary.simpleMessage("Выйти из учетной записи"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Выйти"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Войдите, чтобы включить автоматическую синхронизацию",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage(
      "Дополнительная информация",
    ),
    "muted": MessageLookupByLibrary.simpleMessage("Приглушенный"),
    "newPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Новая парольная фраза",
    ),
    "newPassphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Пароль не совпадает!",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "newRecoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Я записал новый код",
    ),
    "newRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Запишите его и храните в безопасности. Он больше не будет отображаться.",
    ),
    "newRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Код восстановления",
    ),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Пока нет зашифрованных заметок",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Нет данных"),
    "notNow": MessageLookupByLibrary.simpleMessage("Не сейчас"),
    "noteCollapsePreview": MessageLookupByLibrary.simpleMessage(
      "Свернуть предварительный просмотр",
    ),
    "noteDifferentPassphrase": MessageLookupByLibrary.simpleMessage(
      "Эта заметка защищена другой парольной фразой",
    ),
    "noteExpandPreview": MessageLookupByLibrary.simpleMessage(
      "Развернуть предварительный просмотр",
    ),
    "noteNoTitle": MessageLookupByLibrary.simpleMessage("Заметка без имени"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage("Сохранено"),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Заметка успешно обновлена.",
    ),
    "noteWillBeSavedEncrypted": MessageLookupByLibrary.simpleMessage(
      "Примечание будет сохранено в зашифрованном виде",
    ),
    "noteWillBeSavedUnencrypted": MessageLookupByLibrary.simpleMessage(
      "Примечание будет сохранено в незашифрованном виде",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Синхронизация заметок выполнена успешно",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Потратьте несколько минут, чтобы поразмышлять о своем дне в дневнике",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Вы не выбрали время уведомления",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "Время вести дневник!",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "push-уведомления",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage("Страница не найдена"),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Палитра (коснитесь образца для редактирования)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Кодовая фраза"),
    "passphraseLabel": MessageLookupByLibrary.simpleMessage("Кодовая фраза"),
    "passphraseMinLength": m3,
    "passphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Пароль не совпадает!",
    ),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "Шаблон электронного сообщения о сбросе пароля",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Восстановление пароля прошло успешно",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Подтверждение пароля",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Выбери цвет"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Выберите цвет фона",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage("Из файлов"),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage("Вход не выполнен"),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "На экране блокировки отобразится PIN-КОД до 4 цифр",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Введите новый 4-значный ПИН-код.",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Ощущение подтверждения PIN-КОДА",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage("не совпадают;"),
    "pleaseSetupYourAccountToUseThisFeature": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, настройте свою учетную запись, чтобы использовать эту функцию",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage("Проект на GitHub"),
    "recordAudio": MessageLookupByLibrary.simpleMessage("Запись аудио"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage("Код восстановления"),
    "recoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Я записал свой код восстановления",
    ),
    "recoveryCodeCopiedToast": MessageLookupByLibrary.simpleMessage(
      "Код восстановления скопирован",
    ),
    "recoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Запишите это и храните в безопасном месте. Это ЕДИНСТВЕННЫЙ способ восстановить заметки, если вы забыли кодовую фразу. Он больше не будет отображаться.",
    ),
    "regenerateButton": MessageLookupByLibrary.simpleMessage("Регенерировать"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Регенерировать код восстановления",
    ),
    "regenerateRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Это аннулирует ваш старый код восстановления. Введите парольную фразу, чтобы продолжить.",
    ),
    "reminderRemoved": MessageLookupByLibrary.simpleMessage(
      "Напоминание удалено",
    ),
    "reminderSchedulingFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось запланировать напоминание. Повторите попытку.",
    ),
    "reminderSet": MessageLookupByLibrary.simpleMessage(
      "Напоминание включено!",
    ),
    "reminderTimeMustBeInFuture": MessageLookupByLibrary.simpleMessage(
      "Выберите время в будущем",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Напоминания"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Удалить шифрование из этой заметки",
    ),
    "removeReminder": MessageLookupByLibrary.simpleMessage(
      "Удалить напоминание?",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Сброс пароля"),
    "resetPin": MessageLookupByLibrary.simpleMessage("Сброс PIN-кода"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage("Применить тему"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Сохранить настройки"),
    "searchInNoteHint": MessageLookupByLibrary.simpleMessage("Искать в"),
    "security": MessageLookupByLibrary.simpleMessage("Безопасность"),
    "securityBackedUpNotes": MessageLookupByLibrary.simpleMessage("Опираясь"),
    "securityBackupNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Выберите поставщика облачного резервного копирования, чтобы увидеть статистику резервного копирования.",
    ),
    "securityBackupOffline": MessageLookupByLibrary.simpleMessage(
      "Статус резервного копирования недоступен в автономном режиме.",
    ),
    "securityBackupSetupHint": MessageLookupByLibrary.simpleMessage(
      "Включите резервное копирование в облаке, чтобы вы никогда не теряли свои заметки.",
    ),
    "securityBackupSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Настроить резервное копирование",
    ),
    "securityBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Конфиденциальность и резервное копирование",
    ),
    "securityBackupUnverified": MessageLookupByLibrary.simpleMessage(
      "Синхронизируйте один раз, чтобы проверить статус резервного копирования.",
    ),
    "securityEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Зашифрованные заметки",
    ),
    "securityLastSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Последняя успешная синхронизация",
    ),
    "securityLastSync": MessageLookupByLibrary.simpleMessage(
      "Последняя синхронизация",
    ),
    "securityMetricUnavailable": MessageLookupByLibrary.simpleMessage(
      "Недоступен",
    ),
    "securityNoSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Пока нет успешной синхронизации.",
    ),
    "securityPendingBackup": MessageLookupByLibrary.simpleMessage(
      "Требуется резервное копирование",
    ),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Настройки безопасности",
    ),
    "securityStatsNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Вы еще не выбрали облачную платформу для резервного копирования.",
    ),
    "securitySyncedData": MessageLookupByLibrary.simpleMessage(
      "Облачные данные",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Выбрать"),
    "selectVoice": MessageLookupByLibrary.simpleMessage(
      "Выберите <bpt i=\"0\"/>Голосовой ввод<ept i=\"0\"/>.",
    ),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Отправить отзыв"),
    "setPassphrase": MessageLookupByLibrary.simpleMessage(
      "Установить кодовую фразу",
    ),
    "setTodoReminder": MessageLookupByLibrary.simpleMessage(
      "Установить напоминание о задачах",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage(
      "ЗАРЕГИСТРИРОВАТЬСЯ",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Поделиться с друзьями",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Войти"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "Войти с помощью электронной почты",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Зарегистрировался как"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage("Сортировка А-Я"),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "Сортировать по последним",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "Сортировать по дате (сначала старые)",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("Ждите"),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Синхронизировать сейчас"),
    "syncSourceNone": MessageLookupByLibrary.simpleMessage("Нет"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Тег с таким именем уже существует",
    ),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Нажмите здесь, чтобы развернуть заголовок",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Настройка темы, шрифтов и языка",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Название темы"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Моя тема"),
    "to": MessageLookupByLibrary.simpleMessage("Кому"),
    "todoReminderNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Напоминание о задачах",
    ),
    "todoRemindersNeedUncheckedTodo": MessageLookupByLibrary.simpleMessage(
      "Поместите курсор на элемент задачи, чтобы установить напоминание",
    ),
    "todoRemindersUnavailableInEncryptedNotes":
        MessageLookupByLibrary.simpleMessage(
          "Напоминания недоступны в зашифрованных заметках",
        ),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Слишком много неправильных попыток, пожалуйста, войдите с паролем",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Блокировать позицию панели инструментов",
    ),
    "toolbarPositionBottom": MessageLookupByLibrary.simpleMessage("Днище"),
    "toolbarPositionTop": MessageLookupByLibrary.simpleMessage("Сверху"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Неожиданная ошибка ...",
    ),
    "unlockAction": MessageLookupByLibrary.simpleMessage("Разблокировать"),
    "unlockButton": MessageLookupByLibrary.simpleMessage("Разблокировать"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Разблокировать зашифрованные заметки",
    ),
    "unlockNoteAction": MessageLookupByLibrary.simpleMessage(
      "Разблокировать заметку",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Разблокировать это примечание",
    ),
    "usePassphraseInstead": MessageLookupByLibrary.simpleMessage(
      "Вместо этого используйте парольную фразу",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Видео мониторинг"),
    "visitWebsite": MessageLookupByLibrary.simpleMessage(
      "Посетите наш вебсайт",
    ),
    "webdavURL": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Что нового"),
    "whatsNewCloudBackupSubtitle": MessageLookupByLibrary.simpleMessage(
      "Посмотрите, какие заметки сохранены, ожидают загрузки и когда произошла последняя синхронизация.",
    ),
    "whatsNewCloudBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Статус резервного копирования в облаке",
    ),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Защитите конфиденциальные заметки с помощью параметров шифрования и восстановления на основе парольных фраз.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "О шифровании AES:",
    ),
    "whatsNewHomeSearchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Найдите заметки на главной странице и выполняйте поиск внутри заметки во время чтения.",
    ),
    "whatsNewHomeSearchTitle": MessageLookupByLibrary.simpleMessage(
      "Искать везде",
    ),
    "whatsNewStreakTrackingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Отслеживайте текущую серию, самую длинную серию, общее количество слов и тепловую карту активности за 6 месяцев.",
    ),
    "whatsNewStreakTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Полосы и статистика написания",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Персонализируйте DiaryVault с помощью собственных цветов и визуального стиля.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Создание и настройка тем",
    ),
    "whatsNewTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Добавляйте контрольные списки в заметки, создавайте отдельные задачи и получайте уведомления с напоминаниями.",
    ),
    "whatsNewTodosTitle": MessageLookupByLibrary.simpleMessage(
      "Todos с напоминаниями",
    ),
    "writingActivity": MessageLookupByLibrary.simpleMessage(
      "Письменная деятельность",
    ),
    "writingActivityEmpty": MessageLookupByLibrary.simpleMessage(
      "Здесь будут отображаться ваши дни написания.",
    ),
    "writingActivityLess": MessageLookupByLibrary.simpleMessage("Меньше"),
    "writingActivityMore": MessageLookupByLibrary.simpleMessage("Еще"),
    "writingActivityPeriod": MessageLookupByLibrary.simpleMessage(
      "Прошлые 6 месяцев",
    ),
    "writingActivityPrivacyNote": MessageLookupByLibrary.simpleMessage(
      "Зашифрованные заметки не включены в эту статистику.",
    ),
    "writingCurrentStreak": MessageLookupByLibrary.simpleMessage(
      "Текущая серия",
    ),
    "writingDay": MessageLookupByLibrary.simpleMessage("день"),
    "writingDays": MessageLookupByLibrary.simpleMessage("дней"),
    "writingLongestStreak": MessageLookupByLibrary.simpleMessage(
      "Самую длинную серию прибыльных позиций",
    ),
    "writingTotalWords": MessageLookupByLibrary.simpleMessage("Итого слов"),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("Неверный PIN-код"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "У вас есть несохраненные изменения",
    ),
    "youWillBeNotifiedAt": m4,
    "yourRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Код восстановления",
    ),
  };
}
