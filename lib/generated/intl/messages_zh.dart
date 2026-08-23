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

  static String m3(time) => "将在 ${time} 收到提醒";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("强调"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage("账户创建成功"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage("已有帐户？"),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "遇见 diaryVault - 一款帮您轻松记录想法、回忆和精彩瞬间的日记应用。已上线Play Store！",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("语言"),
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
    "changePassword": MessageLookupByLibrary.simpleMessage("修改密码"),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage("选择背景图像"),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage("选择同步源"),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("选择主题"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("选择时间"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("关闭应用？"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("云备份"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage("确认新密码"),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage("确认新PIN码"),
    "continueAsGues": MessageLookupByLibrary.simpleMessage("试用"),
    "create": MessageLookupByLibrary.simpleMessage("创建"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("创建主题"),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "选择您喜欢的照片或选择背景颜色，我们将围绕它构建主题。",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("自定义主题"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage("每日提醒"),
    "darkLabel": MessageLookupByLibrary.simpleMessage("深色"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("深色主题"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("筛选"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("我的主题"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage("删除失败"),
    "done": MessageLookupByLibrary.simpleMessage("完成"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("没有帐户？"),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("编辑主题"),
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
    "encryptedNotes": MessageLookupByLibrary.simpleMessage("加密笔记"),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage("加密笔记已锁定"),
    "encryption": MessageLookupByLibrary.simpleMessage("加密方式"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("已启用"),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage("设置密码和恢复码"),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage("输入密码"),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage("输入新邮箱"),
    "enterPin": MessageLookupByLibrary.simpleMessage("输入您的 PIN 码"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage("输入邮箱"),
    "exportNotes": MessageLookupByLibrary.simpleMessage("导出笔记"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("Export to JSON"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage("导出为PDF （测试功能）"),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage("导出为文本"),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage("获取笔记失败"),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage("保存笔记失败"),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage("请先在系统设置中开启指纹解锁"),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage("指纹登陆失败"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("字体"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("忘记密码"),
    "from": MessageLookupByLibrary.simpleMessage("从"),
    "gallery": MessageLookupByLibrary.simpleMessage("相册"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage("在选定的时间通知您记日记"),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage("导入和导出备注"),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("Import from JSON"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage("密码不正确"),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage("密码错误"),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage("恢复代码不正确。"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("无效的备份文件。"),
    "language": MessageLookupByLibrary.simpleMessage("中文"),
    "lastSynced": MessageLookupByLibrary.simpleMessage("最后同步时间："),
    "leave": MessageLookupByLibrary.simpleMessage("离开"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("亮"),
    "link": MessageLookupByLibrary.simpleMessage("链接"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage("锁定加密笔记"),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("锁定此备注"),
    "logIn": MessageLookupByLibrary.simpleMessage("登录"),
    "logOut": MessageLookupByLibrary.simpleMessage("退出登录"),
    "logOut2": MessageLookupByLibrary.simpleMessage("退出登录"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage("请登录以开启自动同步"),
    "moreInfo": MessageLookupByLibrary.simpleMessage("更多信息"),
    "muted": MessageLookupByLibrary.simpleMessage("已静音"),
    "newPassword": MessageLookupByLibrary.simpleMessage("新密码"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage("尚无加密笔记"),
    "notAvailable": MessageLookupByLibrary.simpleMessage("未知"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage("笔记保存成功"),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage("笔记更新成功"),
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
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage("重新生成恢复代码"),
    "reminders": MessageLookupByLibrary.simpleMessage("提醒"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "从此备注中删除加密",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("重置密码"),
    "resetPin": MessageLookupByLibrary.simpleMessage("重置 PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage("应用主题"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("保存修改"),
    "security": MessageLookupByLibrary.simpleMessage("安全"),
    "securitySettings": MessageLookupByLibrary.simpleMessage("安全设置"),
    "select": MessageLookupByLibrary.simpleMessage("Select"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("请选择语音"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("发送反馈"),
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
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage("标签已存在"),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage("点击此处展开标题"),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "自定义主题、字体和语言",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("主题名称："),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("我的主题"),
    "to": MessageLookupByLibrary.simpleMessage("到"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "尝试次数过多，请使用密码登录",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage("工具栏菜单位置"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage("未知错误"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage("解锁加密笔记"),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage("解锁此备注"),
    "video": MessageLookupByLibrary.simpleMessage("录像"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("最新消息"),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "使用基于密码的加密和恢复选项保护敏感笔记。",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage("关于加密"),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "使用您自己的颜色和视觉风格个性化DiaryVault。",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage("创建和自定义主题"),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("错误的PIN码"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage("修改未保存"),
    "youWillBeNotifiedAt": m3,
  };
}
