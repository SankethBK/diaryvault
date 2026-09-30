// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(imported, skipped, failed) =>
      "导入${imported}笔记，跳过${skipped}现有， ${failed}失败";

  static String m1(imported, skipped) => "已导入${imported}笔记，已跳过${skipped}个现有笔记";

  static String m2(count) => "已导入${count}条备注";

  static String m3(minLength) => "密码必须至少为${minLength}个字符";

  static String m4(time) => "将在 ${time} 收到提醒";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("强调"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage("账户创建成功"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage("已有帐户？"),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "遇见 diaryVault - 一款帮您轻松记录想法、回忆和精彩瞬间的日记应用。已上线Play Store！",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("语言"),
    "appTitle": MessageLookupByLibrary.simpleMessage("我的乳制品"),
    "appVersion": MessageLookupByLibrary.simpleMessage("应用版本"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "确定要退出登录吗？",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage("自动同步"),
    "automaticallySave": MessageLookupByLibrary.simpleMessage("每隔十秒自动保存笔记"),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "自动同步笔记到云端",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "支持的同步平台",
    ),
    "backAction": MessageLookupByLibrary.simpleMessage("回到"),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage("继续表示您同意我们的"),
    "camera": MessageLookupByLibrary.simpleMessage("拍照"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "change": MessageLookupByLibrary.simpleMessage("变动"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage("更改背景色"),
    "changeEmail": MessageLookupByLibrary.simpleMessage("修改邮箱"),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "更改加密密码",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("更换图像"),
    "changePassphraseTitle": MessageLookupByLibrary.simpleMessage("更改密码句..."),
    "changePassword": MessageLookupByLibrary.simpleMessage("修改密码"),
    "changeReminderTime": MessageLookupByLibrary.simpleMessage("变更提醒"),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage("选择背景图像"),
    "choosePassphraseHint": MessageLookupByLibrary.simpleMessage(
      "您将输入此信息以解锁加密笔记。使用一些冗长而难忘的东西。",
    ),
    "choosePassphraseTitle": MessageLookupByLibrary.simpleMessage("选择一个密码短语"),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage("选择同步源"),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("选择主题"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("选择时间"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("关闭应用？"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("云备份"),
    "confirmNewPassphraseLabel": MessageLookupByLibrary.simpleMessage("确认新口令"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage("确认新密码"),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage("确认新PIN码"),
    "confirmPassphraseLabel": MessageLookupByLibrary.simpleMessage("确认您的口令"),
    "continueAsGues": MessageLookupByLibrary.simpleMessage("试用"),
    "continueButton": MessageLookupByLibrary.simpleMessage("继续"),
    "copyButtonTooltip": MessageLookupByLibrary.simpleMessage("复制"),
    "create": MessageLookupByLibrary.simpleMessage("创建"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("创建主题"),
    "currentPassphraseIncorrect": MessageLookupByLibrary.simpleMessage(
      "当前密码不正确",
    ),
    "currentPassphraseLabel": MessageLookupByLibrary.simpleMessage("当前口令"),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "选择您喜欢的照片或选择背景颜色，我们将围绕它构建主题。",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("自定义主题"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage("每日提醒"),
    "darkLabel": MessageLookupByLibrary.simpleMessage("深色"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("深色主题"),
    "dashboardAddTodo": MessageLookupByLibrary.simpleMessage("添加待办事项"),
    "dashboardAnotherPrompt": MessageLookupByLibrary.simpleMessage("其他提示"),
    "dashboardComingSoon": MessageLookupByLibrary.simpleMessage("即将开放，敬请期待"),
    "dashboardCompletedTodos": MessageLookupByLibrary.simpleMessage("已完成"),
    "dashboardCreateTodo": MessageLookupByLibrary.simpleMessage("视需要增加填充棉。"),
    "dashboardDailyPrompt": MessageLookupByLibrary.simpleMessage("每日提示"),
    "dashboardDailyPrompt1": MessageLookupByLibrary.simpleMessage(
      "今天对我来说是一个小小的胜利吗？",
    ),
    "dashboardDailyPrompt2": MessageLookupByLibrary.simpleMessage(
      "从今天开始，我想记住什么时刻？",
    ),
    "dashboardDailyPrompt3": MessageLookupByLibrary.simpleMessage(
      "什么比我今天的预期消耗了更多的精力？",
    ),
    "dashboardDailyPrompt4": MessageLookupByLibrary.simpleMessage("今晚我可以放弃什么？"),
    "dashboardDailyPrompt5": MessageLookupByLibrary.simpleMessage("我今天学到了什么？"),
    "dashboardDailyPrompt6": MessageLookupByLibrary.simpleMessage(
      "是什么让我的日子轻松一点？",
    ),
    "dashboardDailyPrompt7": MessageLookupByLibrary.simpleMessage(
      "什么会让我觉得明天更温和？",
    ),
    "dashboardDailyPrompt8": MessageLookupByLibrary.simpleMessage(
      "今天是什么让我感到感激？",
    ),
    "dashboardDueToday": MessageLookupByLibrary.simpleMessage("今天到期"),
    "dashboardEditTodo": MessageLookupByLibrary.simpleMessage("编辑待办事项"),
    "dashboardMoodCheckIn": MessageLookupByLibrary.simpleMessage("自我检测"),
    "dashboardMoodContextPrompt": MessageLookupByLibrary.simpleMessage(
      "想添加一些背景信息吗？",
    ),
    "dashboardMoodDifficult": MessageLookupByLibrary.simpleMessage("度过艰难的一天"),
    "dashboardMoodGood": MessageLookupByLibrary.simpleMessage("良好"),
    "dashboardMoodGreat": MessageLookupByLibrary.simpleMessage("好棒"),
    "dashboardMoodLow": MessageLookupByLibrary.simpleMessage("不太好"),
    "dashboardMoodNoteTitle": MessageLookupByLibrary.simpleMessage("今天的思考"),
    "dashboardMoodOkay": MessageLookupByLibrary.simpleMessage("確定"),
    "dashboardMoodOpeningDifficult": MessageLookupByLibrary.simpleMessage(
      "今天是艰难的一天。",
    ),
    "dashboardMoodOpeningGood": MessageLookupByLibrary.simpleMessage(
      "今天，我感觉很好。",
    ),
    "dashboardMoodOpeningGreat": MessageLookupByLibrary.simpleMessage(
      "今天，我感觉很好。",
    ),
    "dashboardMoodOpeningLow": MessageLookupByLibrary.simpleMessage(
      "今天，我感觉不太好。",
    ),
    "dashboardMoodOpeningOkay": MessageLookupByLibrary.simpleMessage(
      "今天，我感觉很好。",
    ),
    "dashboardMoodReflectionHint": MessageLookupByLibrary.simpleMessage(
      "您还有其他想法吗？ （选填）",
    ),
    "dashboardMoodSaveToJournal": MessageLookupByLibrary.simpleMessage(
      "添加到今天的备注",
    ),
    "dashboardMoodSubtitle": MessageLookupByLibrary.simpleMessage("您今天觉得怎么样？"),
    "dashboardNoDueDate": MessageLookupByLibrary.simpleMessage("无到期日期"),
    "dashboardNoTodos": MessageLookupByLibrary.simpleMessage("此处尚无待办事项"),
    "dashboardNoTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "您的未完成和已完成任务将显示在此处。",
    ),
    "dashboardOpenInNote": MessageLookupByLibrary.simpleMessage("在备注中打开"),
    "dashboardOpenTodos": MessageLookupByLibrary.simpleMessage("开启"),
    "dashboardOverdue": MessageLookupByLibrary.simpleMessage("超期"),
    "dashboardPromptSubtitle": MessageLookupByLibrary.simpleMessage(
      "一个需要反思的小问题",
    ),
    "dashboardQuickCapture": MessageLookupByLibrary.simpleMessage("一键占星"),
    "dashboardReminderOptional": MessageLookupByLibrary.simpleMessage("提醒邮件"),
    "dashboardSaveTodo": MessageLookupByLibrary.simpleMessage("保存"),
    "dashboardToday": MessageLookupByLibrary.simpleMessage("今天"),
    "dashboardTodoLoadFailed": MessageLookupByLibrary.simpleMessage("无法加载待办事项"),
    "dashboardTodoRequired": MessageLookupByLibrary.simpleMessage("请先输入待办事项"),
    "dashboardTodoSourceHint": MessageLookupByLibrary.simpleMessage(
      "可以从备注中添加待办事项，也可以直接在此处创建待办事项。",
    ),
    "dashboardTodoTitle": MessageLookupByLibrary.simpleMessage("需要做什么？"),
    "dashboardTodoUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "无法更新此待办事项",
    ),
    "dashboardTodos": MessageLookupByLibrary.simpleMessage("托多斯"),
    "dashboardUpcoming": MessageLookupByLibrary.simpleMessage("近期賽事"),
    "dashboardWriteAboutPrompt": MessageLookupByLibrary.simpleMessage("撰写相关信息"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("筛选"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("我的主题"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage("删除失败"),
    "done": MessageLookupByLibrary.simpleMessage("完成"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("没有帐户？"),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("编辑主题"),
    "editorPlaceholder": MessageLookupByLibrary.simpleMessage("在这里写点什么..."),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "重置邮箱成功，请重新登录",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage("开启自动同步"),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage("开启每日提醒"),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage("开启指纹登录"),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage("启用笔记加密"),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage("启用PIN登录"),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "使用只有您知道的密码短语加密敏感笔记。加密笔记在此设备和云备份中受到保护，并位于单独的锁定视图中。",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage("加密此便笺"),
    "encryptYourNotesDescription": MessageLookupByLibrary.simpleMessage(
      "您标记为加密的笔记在此设备上受到保护，并且在您的云备份中使用只有您知道的密码。其他任何人-包括我们和您的云提供商-都无法阅读它们。",
    ),
    "encryptYourNotesTitle": MessageLookupByLibrary.simpleMessage("加密笔记"),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage("加密笔记"),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage("加密笔记已锁定"),
    "encryption": MessageLookupByLibrary.simpleMessage("加密方式"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("已启用"),
    "encryptionEnabledToast": MessageLookupByLibrary.simpleMessage("已启用加密"),
    "encryptionLossAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "我明白，如果我忘记了此密码并丢失了恢复代码，则无法恢复我的笔记",
    ),
    "encryptionLossWarning": MessageLookupByLibrary.simpleMessage(
      "⚠️ 如果您忘记了密码并丢失了恢复代码，加密的笔记将永远消失。没有办法找回它们。",
    ),
    "encryptionSeparateViewDescription": MessageLookupByLibrary.simpleMessage(
      "加密笔记位于单独的锁定视图中，不会被搜索到。",
    ),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage("设置密码和恢复码"),
    "encryptionStaysOnToast": MessageLookupByLibrary.simpleMessage(
      "加密笔记会保持加密状态。从加密笔记视图随时锁定它们。",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage("输入密码"),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage("输入新邮箱"),
    "enterPin": MessageLookupByLibrary.simpleMessage("输入您的 PIN 码"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage("输入邮箱"),
    "exportNotes": MessageLookupByLibrary.simpleMessage("导出笔记"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("导出为 JSON"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage("导出为PDF （测试功能）"),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage("导出为文本"),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage("获取笔记失败"),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage("保存笔记失败"),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage("请先在系统设置中开启指纹解锁"),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage("指纹登陆失败"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("字体"),
    "forgotPassphraseUseRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "忘记密码？使用恢复码",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("忘记密码"),
    "from": MessageLookupByLibrary.simpleMessage("从"),
    "gallery": MessageLookupByLibrary.simpleMessage("相册"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage("在选定的时间通知您记日记"),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage("导入和导出备注"),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("从 JSON 导入"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage("密码不正确"),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage("密码错误"),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage("恢复代码不正确。"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("无效的备份文件。"),
    "language": MessageLookupByLibrary.simpleMessage("中文"),
    "lastSynced": MessageLookupByLibrary.simpleMessage("最后同步时间："),
    "leave": MessageLookupByLibrary.simpleMessage("离开"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("亮"),
    "link": MessageLookupByLibrary.simpleMessage("链接"),
    "lockAction": MessageLookupByLibrary.simpleMessage("锁定"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage("锁定加密笔记"),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("锁定此备注"),
    "logIn": MessageLookupByLibrary.simpleMessage("登录"),
    "logOut": MessageLookupByLibrary.simpleMessage("退出登录"),
    "logOut2": MessageLookupByLibrary.simpleMessage("退出登录"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage("请登录以开启自动同步"),
    "moreInfo": MessageLookupByLibrary.simpleMessage("更多信息"),
    "muted": MessageLookupByLibrary.simpleMessage("已静音"),
    "newPassphraseLabel": MessageLookupByLibrary.simpleMessage("新口令"),
    "newPassphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage("密码短语不匹配"),
    "newPassword": MessageLookupByLibrary.simpleMessage("新密码"),
    "newRecoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "我已经写下了新代码",
    ),
    "newRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "把它写下来并保持安全。它将不再显示。",
    ),
    "newRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage("新的救援码"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage("尚无加密笔记"),
    "notAvailable": MessageLookupByLibrary.simpleMessage("未知"),
    "notNow": MessageLookupByLibrary.simpleMessage("立即购买"),
    "noteCollapsePreview": MessageLookupByLibrary.simpleMessage("折叠预览"),
    "noteDifferentPassphrase": MessageLookupByLibrary.simpleMessage(
      "此备注受其他密码保护",
    ),
    "noteExpandPreview": MessageLookupByLibrary.simpleMessage("展开预览"),
    "noteNoTitle": MessageLookupByLibrary.simpleMessage("无标题备注"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage("笔记保存成功"),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage("笔记更新成功"),
    "noteWillBeSavedEncrypted": MessageLookupByLibrary.simpleMessage("备注将加密保存"),
    "noteWillBeSavedUnencrypted": MessageLookupByLibrary.simpleMessage(
      "备注将未加密保存",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage("笔记同步成功"),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "花几分钟记下今日感悟吧",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "未选择提醒时间",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage("日记时间！"),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage("未开启提醒"),
    "pageNotFound": MessageLookupByLibrary.simpleMessage("未找到页面"),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage("调色板（点击色板进行编辑）"),
    "passphrase": MessageLookupByLibrary.simpleMessage("密码短语 "),
    "passphraseLabel": MessageLookupByLibrary.simpleMessage("密码短语 "),
    "passphraseMinLength": m3,
    "passphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage("密码短语不匹配"),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage("重置密码邮件已发送"),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage("密码重置成功"),
    "passwordVerified": MessageLookupByLibrary.simpleMessage("密码正确"),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage("密码不一致"),
    "pickAColor": MessageLookupByLibrary.simpleMessage("选择一个颜色"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "选择一种背景色",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage("从文件中挑选"),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage(" 登录失败"),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "锁定屏幕上将提示最多4位数的PIN码",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage("请输入4到8位的PIN。"),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage("PIN码确认感觉"),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage("PIN码不匹配"),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage("请创建账户以使用此功能"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage("Github上的项目"),
    "recordAudio": MessageLookupByLibrary.simpleMessage("录制音频"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage("救援码"),
    "recoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "我已经写下我的救援码",
    ),
    "recoveryCodeCopiedToast": MessageLookupByLibrary.simpleMessage("救援码已复制"),
    "recoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "把它写下来，放在安全的地方。如果您忘记了密码，这是恢复笔记的唯一方法。它将不再显示。",
    ),
    "regenerateButton": MessageLookupByLibrary.simpleMessage("重新生成"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage("重新生成恢复代码"),
    "regenerateRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "这将使您的旧恢复代码无效。输入您的密码以继续。",
    ),
    "reminderRemoved": MessageLookupByLibrary.simpleMessage("已删除提醒"),
    "reminderSchedulingFailed": MessageLookupByLibrary.simpleMessage(
      "无法安排提醒。请重试。",
    ),
    "reminderSet": MessageLookupByLibrary.simpleMessage("提醒集"),
    "reminderTimeMustBeInFuture": MessageLookupByLibrary.simpleMessage(
      "请选择未来的时间",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("提醒"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "从此备注中删除加密",
    ),
    "removeReminder": MessageLookupByLibrary.simpleMessage("移除提醒"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("重置密码"),
    "resetPin": MessageLookupByLibrary.simpleMessage("重置 PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage("应用主题"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("保存修改"),
    "searchInNoteHint": MessageLookupByLibrary.simpleMessage("搜索范围"),
    "security": MessageLookupByLibrary.simpleMessage("安全"),
    "securityBackedUpNotes": MessageLookupByLibrary.simpleMessage("已备份 "),
    "securityBackupNotConfigured": MessageLookupByLibrary.simpleMessage(
      "选择云备份提供商以查看备份统计信息。",
    ),
    "securityBackupOffline": MessageLookupByLibrary.simpleMessage(
      "备份状态不可离线使用。",
    ),
    "securityBackupSetupHint": MessageLookupByLibrary.simpleMessage(
      "启用云备份，这样您就不会丢失笔记。",
    ),
    "securityBackupSetupTitle": MessageLookupByLibrary.simpleMessage("设置备份"),
    "securityBackupTitle": MessageLookupByLibrary.simpleMessage("隐私与备份"),
    "securityBackupUnverified": MessageLookupByLibrary.simpleMessage(
      "同步一次以验证您的备份状态。",
    ),
    "securityEncryptedNotes": MessageLookupByLibrary.simpleMessage("加密笔记"),
    "securityLastSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "上次成功同步:",
    ),
    "securityLastSync": MessageLookupByLibrary.simpleMessage("上次同步"),
    "securityMetricUnavailable": MessageLookupByLibrary.simpleMessage("尚未开始"),
    "securityNoSuccessfulSync": MessageLookupByLibrary.simpleMessage("尚未成功同步。"),
    "securityPendingBackup": MessageLookupByLibrary.simpleMessage("需要备份"),
    "securitySettings": MessageLookupByLibrary.simpleMessage("安全设置"),
    "securityStatsNotConfigured": MessageLookupByLibrary.simpleMessage(
      "您尚未选择云备份平台。",
    ),
    "securitySyncedData": MessageLookupByLibrary.simpleMessage("云端数据"),
    "select": MessageLookupByLibrary.simpleMessage("选择大奖"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("请选择语音"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("发送反馈"),
    "setPassphrase": MessageLookupByLibrary.simpleMessage("设置密码"),
    "setTodoReminder": MessageLookupByLibrary.simpleMessage("待办"),
    "settings": MessageLookupByLibrary.simpleMessage("设置"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage("创建账户"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage("邀请朋友"),
    "signIn": MessageLookupByLibrary.simpleMessage("注册"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage("使用电子邮件登录"),
    "signUp": MessageLookupByLibrary.simpleMessage("注册"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("注册"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage("名称排序"),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage("从新到旧"),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage("从旧到新"),
    "stay": MessageLookupByLibrary.simpleMessage("留下"),
    "submit": MessageLookupByLibrary.simpleMessage("确定"),
    "syncNow": MessageLookupByLibrary.simpleMessage("立即同步"),
    "syncSourceNone": MessageLookupByLibrary.simpleMessage("无"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage("标签已存在"),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage("点击此处展开标题"),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "自定义主题、字体和语言",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("主题名称："),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("我的主题"),
    "to": MessageLookupByLibrary.simpleMessage("到"),
    "todoReminderNotificationTitle": MessageLookupByLibrary.simpleMessage("待办"),
    "todoRemindersNeedUncheckedTodo": MessageLookupByLibrary.simpleMessage(
      "将光标放在待办事项上以设置提醒",
    ),
    "todoRemindersUnavailableInEncryptedNotes":
        MessageLookupByLibrary.simpleMessage("加密笔记中没有提醒"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "尝试次数过多，请使用密码登录",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage("工具栏菜单位置"),
    "toolbarPositionBottom": MessageLookupByLibrary.simpleMessage("底铺"),
    "toolbarPositionTop": MessageLookupByLibrary.simpleMessage("Top"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage("未知错误"),
    "unlockAction": MessageLookupByLibrary.simpleMessage("解锁"),
    "unlockButton": MessageLookupByLibrary.simpleMessage("解锁"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage("解锁加密笔记"),
    "unlockNoteAction": MessageLookupByLibrary.simpleMessage("解锁备注"),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage("解锁此备注"),
    "usePassphraseInstead": MessageLookupByLibrary.simpleMessage("改用密码短语"),
    "video": MessageLookupByLibrary.simpleMessage("录像"),
    "visitWebsite": MessageLookupByLibrary.simpleMessage("访问我们的网站"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("最新消息"),
    "whatsNewCloudBackupSubtitle": MessageLookupByLibrary.simpleMessage(
      "查看备份的笔记、待上传的笔记以及上次同步的时间。",
    ),
    "whatsNewCloudBackupTitle": MessageLookupByLibrary.simpleMessage("云备份状态"),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "使用基于密码的加密和恢复选项保护敏感笔记。",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage("关于加密"),
    "whatsNewHomeSearchSubtitle": MessageLookupByLibrary.simpleMessage(
      "从主页中查找笔记，并在阅读时搜索笔记内部。",
    ),
    "whatsNewHomeSearchTitle": MessageLookupByLibrary.simpleMessage("搜索所有内容"),
    "whatsNewStreakTrackingSubtitle": MessageLookupByLibrary.simpleMessage(
      "跟踪您当前的连胜次数、最长连胜次数、总字数和6个月的活动热图。",
    ),
    "whatsNewStreakTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "书写条纹和统计数据",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "使用您自己的颜色和视觉风格个性化DiaryVault。",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage("创建和自定义主题"),
    "whatsNewTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "在备注中添加核对清单，创建独立待办事项，并通过提醒获得通知。",
    ),
    "whatsNewTodosTitle": MessageLookupByLibrary.simpleMessage("带提醒的待办事项"),
    "writingActivity": MessageLookupByLibrary.simpleMessage("写作活动"),
    "writingActivityEmpty": MessageLookupByLibrary.simpleMessage(
      "您的写作日期将显示在此处。",
    ),
    "writingActivityLess": MessageLookupByLibrary.simpleMessage("更少"),
    "writingActivityMore": MessageLookupByLibrary.simpleMessage("更多"),
    "writingActivityPeriod": MessageLookupByLibrary.simpleMessage("过去 6 个月"),
    "writingActivityPrivacyNote": MessageLookupByLibrary.simpleMessage(
      "这些统计数据中不包括加密笔记。",
    ),
    "writingCurrentStreak": MessageLookupByLibrary.simpleMessage("当前连胜"),
    "writingDay": MessageLookupByLibrary.simpleMessage("天"),
    "writingDays": MessageLookupByLibrary.simpleMessage("天"),
    "writingLongestStreak": MessageLookupByLibrary.simpleMessage("最长连胜"),
    "writingTotalWords": MessageLookupByLibrary.simpleMessage("总字数"),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("错误的PIN码"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage("修改未保存"),
    "youWillBeNotifiedAt": m4,
    "yourRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage("您的救援码"),
  };
}
