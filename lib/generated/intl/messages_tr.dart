// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
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
  String get localeName => 'tr';

  static String m0(imported, skipped, failed) =>
      "İçe aktarılan ${imported} notlar, atlanan ${skipped} mevcut, ${failed} başarısız";

  static String m1(imported, skipped) =>
      "İçe aktarılan ${imported} notlar, atlanan ${skipped} mevcut notlar";

  static String m2(count) => "${count} not içe aktarıldı";

  static String m3(minLength) => "Parola en az ${minLength} karakter olmalıdır";

  static String m4(time) => "${time} saatinde bilgilendirileceksiniz";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Şive"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Hesap kurulumu başarılı",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Zaten bir hesabınız var mı?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "DiaryVault\'u keşfedin - düşüncelerinizi, anılarınızı ve anlarınızı zahmetsizce yakalamanıza yardımcı olmak için tasarlanmış bir günlük uygulaması. Şimdi Play Store\'da!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("Uygulama Dili"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Süt Ürünlerim"),
    "appVersion": MessageLookupByLibrary.simpleMessage("Uygulama versiyonu"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "Oturumu kapatmak istediğinizden emin misiniz?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage("Otomatik senkronizasyon"),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Notlarınızı her 10 saniyede bir otomatik olarak kaydeder",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Notları bulutla otomatik olarak senkronize edin",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Senkronizasyon için kullanılabilir platformlar",
    ),
    "backAction": MessageLookupByLibrary.simpleMessage("Geri"),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "Devam ederek, kabul etmiş olursunuz",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Kamera"),
    "cancel": MessageLookupByLibrary.simpleMessage("İptal"),
    "change": MessageLookupByLibrary.simpleMessage("Değişim"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Arkaplan Rengini Değiştir",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage("E-posta değiştir"),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Şifreleme parolasını değiştir",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Görüntüyü değiştir"),
    "changePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Parolayı Değiştir...",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Şifre değiştir"),
    "changeReminderTime": MessageLookupByLibrary.simpleMessage(
      "Hatırlatma süresini değiştir",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Bir Arka Plan Görüntüsü Seç",
    ),
    "choosePassphraseHint": MessageLookupByLibrary.simpleMessage(
      "Şifreli notların kilidini açmak için bunu gireceksin. Uzun ve akılda kalıcı bir şey kullanın.",
    ),
    "choosePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Bir parola seçin",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Senkronizasyon Kaynağını Seç",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Tema Seç"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("Zaman Seçin"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("Uygulamayı kapat?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("Bulut Yedekleme"),
    "confirmNewPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Yeni parolayı onaylayın",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Yeni şifreyi onaylayın",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage(
      "Yeni PIN\'i onaylayın",
    ),
    "confirmPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Parolayı onaylayın",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Misafir olarak devam et",
    ),
    "continueButton": MessageLookupByLibrary.simpleMessage("Devam et"),
    "copyButtonTooltip": MessageLookupByLibrary.simpleMessage("Kopyala"),
    "create": MessageLookupByLibrary.simpleMessage("Oluştur"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage(
      "Temanızı oluşturun",
    ),
    "currentPassphraseIncorrect": MessageLookupByLibrary.simpleMessage(
      "Mevcut parola yanlış",
    ),
    "currentPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Geçerli parola",
    ),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Sevdiğiniz bir fotoğrafı seçin veya bir arka plan rengi seçin, biz de bunun etrafında bir tema oluşturalım.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("Özel Temalar"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage(
      "Günlük Hatırlatmalar",
    ),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Koyu"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Koyu tema"),
    "dashboardAddTodo": MessageLookupByLibrary.simpleMessage(
      "Yapılacak ögesi ekle",
    ),
    "dashboardAnotherPrompt": MessageLookupByLibrary.simpleMessage(
      "Başka bir bilgi istemi",
    ),
    "dashboardComingSoon": MessageLookupByLibrary.simpleMessage("Çok yakında"),
    "dashboardCompletedTodos": MessageLookupByLibrary.simpleMessage(
      "Tamamlandı",
    ),
    "dashboardCreateTodo": MessageLookupByLibrary.simpleMessage("Ekle"),
    "dashboardDailyPrompt": MessageLookupByLibrary.simpleMessage(
      "Günlük bilgi istemi",
    ),
    "dashboardDailyPrompt1": MessageLookupByLibrary.simpleMessage(
      "Bugün benim için küçük bir zafer gibi hissettiren neydi?",
    ),
    "dashboardDailyPrompt2": MessageLookupByLibrary.simpleMessage(
      "Bugünden itibaren hangi anı hatırlamak istiyorum?",
    ),
    "dashboardDailyPrompt3": MessageLookupByLibrary.simpleMessage(
      "Bugün beklediğimden daha fazla enerji gerektiren şey neydi?",
    ),
    "dashboardDailyPrompt4": MessageLookupByLibrary.simpleMessage(
      "Bu gece neyi bırakabilirim?",
    ),
    "dashboardDailyPrompt5": MessageLookupByLibrary.simpleMessage(
      "Bugün kendim hakkında ne öğrendim?",
    ),
    "dashboardDailyPrompt6": MessageLookupByLibrary.simpleMessage(
      "Günümü biraz daha kolaylaştıran neydi?",
    ),
    "dashboardDailyPrompt7": MessageLookupByLibrary.simpleMessage(
      "Yarını benim için daha yumuşak hissettiren şey ne olurdu?",
    ),
    "dashboardDailyPrompt8": MessageLookupByLibrary.simpleMessage(
      "Bugün beni minnettar hissettiren neydi?",
    ),
    "dashboardDueToday": MessageLookupByLibrary.simpleMessage(
      "Bugün yapılacak",
    ),
    "dashboardEditTodo": MessageLookupByLibrary.simpleMessage(
      "Yapılacak ögesini düzen",
    ),
    "dashboardMoodCheckIn": MessageLookupByLibrary.simpleMessage("Giriş"),
    "dashboardMoodContextPrompt": MessageLookupByLibrary.simpleMessage(
      "Biraz bağlam eklemek ister misiniz?",
    ),
    "dashboardMoodDifficult": MessageLookupByLibrary.simpleMessage(
      "Zor bir gün geçiriyor",
    ),
    "dashboardMoodGood": MessageLookupByLibrary.simpleMessage("İyi"),
    "dashboardMoodGreat": MessageLookupByLibrary.simpleMessage(
      "Çok Çok Şidetli",
    ),
    "dashboardMoodLow": MessageLookupByLibrary.simpleMessage("Bu iyi değil..."),
    "dashboardMoodNoteTitle": MessageLookupByLibrary.simpleMessage(
      "Bugünün yansıması",
    ),
    "dashboardMoodOkay": MessageLookupByLibrary.simpleMessage("Tamam."),
    "dashboardMoodOpeningDifficult": MessageLookupByLibrary.simpleMessage(
      "Bugün zor bir gün oldu.",
    ),
    "dashboardMoodOpeningGood": MessageLookupByLibrary.simpleMessage(
      "Bugün kendimi iyi hissediyorum.",
    ),
    "dashboardMoodOpeningGreat": MessageLookupByLibrary.simpleMessage(
      "Bugün kendimi harika hissediyorum.",
    ),
    "dashboardMoodOpeningLow": MessageLookupByLibrary.simpleMessage(
      "Bugün kendimi iyi hissetmiyorum.",
    ),
    "dashboardMoodOpeningOkay": MessageLookupByLibrary.simpleMessage(
      "Bugün kendimi iyi hissediyorum.",
    ),
    "dashboardMoodReflectionHint": MessageLookupByLibrary.simpleMessage(
      "Aklında başka bir şey var mı? (isteğe bağlı)",
    ),
    "dashboardMoodSaveToJournal": MessageLookupByLibrary.simpleMessage(
      "Bugünkü nota ekle",
    ),
    "dashboardMoodSubtitle": MessageLookupByLibrary.simpleMessage(
      "Bugün nasıl hissediyorsun?",
    ),
    "dashboardNoDueDate": MessageLookupByLibrary.simpleMessage(
      "Bitiş tarihi yokexcept for listed dates",
    ),
    "dashboardNoTodos": MessageLookupByLibrary.simpleMessage(
      "Henüz burada yapılacak iş yok",
    ),
    "dashboardNoTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Açık ve tamamlanmış görevleriniz burada görünecektir.",
    ),
    "dashboardOpenInNote": MessageLookupByLibrary.simpleMessage("Notta aç"),
    "dashboardOpenTodos": MessageLookupByLibrary.simpleMessage("Aç"),
    "dashboardOverdue": MessageLookupByLibrary.simpleMessage("Gecikmeli"),
    "dashboardPromptSubtitle": MessageLookupByLibrary.simpleMessage(
      "Üzerinde düşünülmesi gereken küçük bir soru",
    ),
    "dashboardQuickCapture": MessageLookupByLibrary.simpleMessage(
      "Hızlı yakalama",
    ),
    "dashboardReminderOptional": MessageLookupByLibrary.simpleMessage(
      "Hatırlatıcı kümesi",
    ),
    "dashboardSaveTodo": MessageLookupByLibrary.simpleMessage("Kaydet"),
    "dashboardToday": MessageLookupByLibrary.simpleMessage("Bugun"),
    "dashboardTodoLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Yapılacak ögeleri yüklenemedi",
    ),
    "dashboardTodoRequired": MessageLookupByLibrary.simpleMessage(
      "Önce bir yapılacak ögesi girin",
    ),
    "dashboardTodoSourceHint": MessageLookupByLibrary.simpleMessage(
      "Yapılacak ögeleri bir nottan eklenebilir veya doğrudan burada oluşturulabilir.",
    ),
    "dashboardTodoTitle": MessageLookupByLibrary.simpleMessage(
      "Ne yapılması gerekiyor?",
    ),
    "dashboardTodoUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Bu yapılacak ögesi güncellenemedi",
    ),
    "dashboardTodos": MessageLookupByLibrary.simpleMessage(
      "Yapılacaklar@ item: inlistbox, calendar entries",
    ),
    "dashboardUpcoming": MessageLookupByLibrary.simpleMessage("Yaklaşan"),
    "dashboardWriteAboutPrompt": MessageLookupByLibrary.simpleMessage(
      "Bunun hakkında yazın",
    ),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Tarih Filtresi"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Benim Temam"),
    "delete": MessageLookupByLibrary.simpleMessage("Sil"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage(
      "Silme başarısız oldu",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Tamam"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Hesabınız yok mu?",
    ),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Temayı düzenle"),
    "editorPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Buraya bir şeyler yazın...",
    ),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "E-posta başarıyla güncellendi, lütfen tekrar giriş yapın",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage(
      "Otomatik kaydetmeyi etkinleştir",
    ),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Günlük Hatırlatmaları Etkinleştir",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Parmak izi ile giriş yapmayı etkinleştir",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Not şifrelemesini etkinleştir",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "PIN ile giriş yapmayı etkinleştir",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Hassas notları yalnızca sizin bildiğiniz bir parola ile şifreleyin. Şifrelenmiş notlar bu cihazda ve bulut yedeklemenizde korunur ve ayrı bir kilitli görünümde bulunur.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage("Bu notu şifrele"),
    "encryptYourNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş olarak işaretlediğiniz notlar bu cihazda ve bulut yedeklemenizde yalnızca sizin bildiğiniz bir parolayla korunur. Biz ve bulut sağlayıcınız da dahil olmak üzere başka hiç kimse bunları okuyamaz.",
    ),
    "encryptYourNotesTitle": MessageLookupByLibrary.simpleMessage(
      "Notlarınızı şifreleyin",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş notlar",
    ),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş notlar kilitlendi",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Şifreleme"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Aktif"),
    "encryptionEnabledToast": MessageLookupByLibrary.simpleMessage(
      "Şifreleme etkin",
    ),
    "encryptionLossAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Bu parolayı unutursam ve kurtarma kodunu kaybedersem notlarımı kurtarmanın bir yolu olmadığını anlıyorum",
    ),
    "encryptionLossWarning": MessageLookupByLibrary.simpleMessage(
      "⚠️ Parolanızı unutursanız VE kurtarma kodunu kaybederseniz, şifrelenmiş notlar sonsuza dek kaybolur. Onları kurtarmanın bir yolu yok.",
    ),
    "encryptionSeparateViewDescription": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş notlar ayrı bir kilitli görünümde bulunur ve aramadan hariç tutulur.",
    ),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Bir parola ve kurtarma kodu oluşturun",
    ),
    "encryptionStaysOnToast": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş notlar için şifreleme açık kalır. Şifrelenmiş notlar görünümünden istediğiniz zaman kilitleyin.",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Mevcut şifreyi girin",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage("Yeni e-posta girin"),
    "enterPin": MessageLookupByLibrary.simpleMessage("PIN\'inizi girin"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Kayıtlı e-posta adresini girin",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Notları dışa aktar"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("JSON\'a Çıktısı"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage(
      "PDF Olarak Dışa Aktar",
    ),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Düz Metin Olarak Dışa Aktar",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage("Not alınamadı"),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage(
      "Not kaydedilemedi",
    ),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "Parmak izi doğrulama cihaz ayarlarında etkinleştirilmelidir",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Parmak izi ile giriş başarısız",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Yazı Tipi"),
    "forgotPassphraseUseRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Parolanızı mı unuttunuz? Kurtarma kodunu kullanın",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Şifrenizi mi unuttunuz?",
    ),
    "from": MessageLookupByLibrary.simpleMessage("Başlangıç"),
    "gallery": MessageLookupByLibrary.simpleMessage("Galeri"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Günlüğünüzü güncel tutmak için seçtiğiniz saatte günlük hatırlatmalar alın.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Notları İçe ve Dışa Aktar",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("Şuradan içe aktar"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Yanlış parola",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage("Hatalı şifre"),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Hatalı kurtarma kodu.",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Geçersiz yedekleme dosyası",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Türkçe"),
    "lastSynced": MessageLookupByLibrary.simpleMessage("Son senkronizasyon: "),
    "leave": MessageLookupByLibrary.simpleMessage("Ayrıl"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Hafif"),
    "link": MessageLookupByLibrary.simpleMessage("Bağlantı"),
    "lockAction": MessageLookupByLibrary.simpleMessage("Kilitle"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş notları kilitle",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("Bu notu kilitle"),
    "logIn": MessageLookupByLibrary.simpleMessage("Giriş Yap"),
    "logOut": MessageLookupByLibrary.simpleMessage("Çıkış Yap"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Çıkış Yap"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Otomatik senkronizasyonu etkinleştirmek için giriş yapın",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("Daha Fazla Bilgi"),
    "muted": MessageLookupByLibrary.simpleMessage("sessiz"),
    "newPassphraseLabel": MessageLookupByLibrary.simpleMessage("Yeni parola"),
    "newPassphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Yeni parolalar eşleşmiyor",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Yeni Şifre"),
    "newRecoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Yeni kodu yazdım",
    ),
    "newRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Yazın ve güvende tutun. Bir daha gösterilmeyecek.",
    ),
    "newRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Yeni kurtarma kodu",
    ),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Henüz şifrelenmiş not yok",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Mevcut değil"),
    "notNow": MessageLookupByLibrary.simpleMessage("Şimdi değil"),
    "noteCollapsePreview": MessageLookupByLibrary.simpleMessage(
      "Önizlemeyi daralt",
    ),
    "noteDifferentPassphrase": MessageLookupByLibrary.simpleMessage(
      "Bu not farklı bir parola ile korunmaktadır",
    ),
    "noteExpandPreview": MessageLookupByLibrary.simpleMessage(
      "Önizlemeyi genişlet",
    ),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Not başarıyla kaydedildi",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Not başarıyla güncellendi",
    ),
    "noteWillBeSavedEncrypted": MessageLookupByLibrary.simpleMessage(
      "Not şifrelenmiş olarak kaydedilecektir",
    ),
    "noteWillBeSavedUnencrypted": MessageLookupByLibrary.simpleMessage(
      "Not şifrelenmeden kaydedilecek",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Notlar başarıyla senkronize edildi",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Günlüğünüzde gününüzü yansıtmak için birkaç dakika ayırın",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Bir bildirim zamanı seçmediniz",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "Günlüğe Zaman!",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Bildirimler etkinleştirilmedi",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage("Sayfa bulunamadı"),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Palet (düzenlemek için bir örneğe dokunun)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Parola"),
    "passphraseLabel": MessageLookupByLibrary.simpleMessage("Parola"),
    "passphraseMinLength": m3,
    "passphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Parolalar eşleşmiyor",
    ),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "Şifre sıfırlama e-postası gönderildi",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Şifre sıfırlama başarılı",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Şifre doğrulandı",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Şifreler eşleşmiyor",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Bir renk seç"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Arkaplan rengi seç",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage(
      "Dosyalardan Seç",
    ),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage(
      "PIN ile giriş başarısız oldu",
    ),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "Ekran kilidinde 4 haneli bir PIN sorulacaktır",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Lütfen 4 haneli bir PIN girin",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "PIN başarıyla sıfırlandı",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage(
      "PIN\'ler eşleşmiyor",
    ),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage(
          "Bu özelliği kullanmak için lütfen hesabınızı ayarlayın",
        ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Gizlilik Politikası",
    ),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage("Proje Github\'da"),
    "recordAudio": MessageLookupByLibrary.simpleMessage("Ses Kaydet"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage("Kurtarma kodu"),
    "recoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Kurtarma kodumu yazdım",
    ),
    "recoveryCodeCopiedToast": MessageLookupByLibrary.simpleMessage(
      "Kurtarma kodu kopyalandı",
    ),
    "recoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Bunu yazın ve güvenli bir yerde saklayın. Parolayı unutursanız notlarınızı kurtarmanın TEK yolu budur. Bir daha gösterilmeyecek.",
    ),
    "regenerateButton": MessageLookupByLibrary.simpleMessage("Canlandırmak"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Kurtarma kodunu yeniden oluştur",
    ),
    "regenerateRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Bu, eski kurtarma kodunuzu geçersiz kılar. Devam etmek için parolanızı girin.",
    ),
    "reminderRemoved": MessageLookupByLibrary.simpleMessage(
      "Hatırlatıcı kaldırıldı",
    ),
    "reminderSchedulingFailed": MessageLookupByLibrary.simpleMessage(
      "Hatırlatıcı zamanlanamadı. Lütfen tekrar deneyin.",
    ),
    "reminderSet": MessageLookupByLibrary.simpleMessage("Hatırlatıcı kümesi"),
    "reminderTimeMustBeInFuture": MessageLookupByLibrary.simpleMessage(
      "Lütfen gelecekte bir saat seçin",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Hatırlatmalar"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Bu nottan şifrelemeyi kaldır",
    ),
    "removeReminder": MessageLookupByLibrary.simpleMessage(
      "Hatırlatıcıyı kaldır",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Şifre sıfırla"),
    "resetPin": MessageLookupByLibrary.simpleMessage("PIN Sıfırla"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage(
      "Temayı kaydet ve uygula",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Değişiklikleri Kaydet",
    ),
    "searchInNoteHint": MessageLookupByLibrary.simpleMessage("Şurada ara:"),
    "security": MessageLookupByLibrary.simpleMessage("Güvenlik"),
    "securityBackedUpNotes": MessageLookupByLibrary.simpleMessage(
      "Yedeklenmiş ",
    ),
    "securityBackupNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Yedekleme istatistiklerini görmek için bir bulut yedekleme sağlayıcısı seçin.",
    ),
    "securityBackupOffline": MessageLookupByLibrary.simpleMessage(
      "Yedekleme durumu çevrimdışı olarak kullanılamıyor.",
    ),
    "securityBackupSetupHint": MessageLookupByLibrary.simpleMessage(
      "Notlarınızı asla kaybetmemek için bulut yedeklemesini etkinleştirin.",
    ),
    "securityBackupSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Yedeklemeyi ayarla",
    ),
    "securityBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Gizlilik ve yedekleme",
    ),
    "securityBackupUnverified": MessageLookupByLibrary.simpleMessage(
      "Yedekleme durumunuzu doğrulamak için bir kez senkronize edin.",
    ),
    "securityEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş notlar",
    ),
    "securityLastSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Son başarılı senkronizasyon",
    ),
    "securityLastSync": MessageLookupByLibrary.simpleMessage(
      "Son senkronizasyon",
    ),
    "securityMetricUnavailable": MessageLookupByLibrary.simpleMessage(
      "Kullanılamıyor",
    ),
    "securityNoSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Henüz başarılı bir senkronizasyon yok.",
    ),
    "securityPendingBackup": MessageLookupByLibrary.simpleMessage(
      "Yedekleme gerekiyor",
    ),
    "securitySettings": MessageLookupByLibrary.simpleMessage(
      "Güvenlik Ayarları",
    ),
    "securityStatsNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Henüz bir bulut yedekleme platformu seçmediniz.",
    ),
    "securitySyncedData": MessageLookupByLibrary.simpleMessage(
      "البيانات السحابية",
    ),
    "select": MessageLookupByLibrary.simpleMessage("Seç"),
    "selectVoice": MessageLookupByLibrary.simpleMessage(
      "SeÃ§enekli. Buraya herhangi sunucu komut satÄ±r seÃ§enekleri girin. Mevcut seÃ§enekleri gÃ¶rmek iÃ§in, uÃ§birim iÃ§inde \"epos - h\" girin. \"- o\" kullanmayÄ±n.",
    ),
    "sendFeedback": MessageLookupByLibrary.simpleMessage(
      "Geri bildirim gönder",
    ),
    "setPassphrase": MessageLookupByLibrary.simpleMessage("Parolayı ayarla"),
    "setTodoReminder": MessageLookupByLibrary.simpleMessage(
      "Yapılacaklar hatırlatıcısını ayarla",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Ayarlar"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage(
      "Hesabınızı Ayarlayın",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Arkadaşlarla paylaş",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Giriş Yap"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "E-posta ile giriş yap",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Kayıt Ol"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Olarak giriş yapıldı"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage("A\'dan Z\'ye Sırala"),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "En Yeniden Başlayarak Sırala",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "En Eskiden Başlayarak Sırala",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("Kal"),
    "submit": MessageLookupByLibrary.simpleMessage("Gönder"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Şimdi senkronize et"),
    "syncSourceNone": MessageLookupByLibrary.simpleMessage("Yok"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Etiket zaten mevcut",
    ),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Başlığı genişletmek için dokunun",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Temayı, Yazı Tiplerini ve Dili Özelleştir",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Tema adı"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Benim Temam"),
    "to": MessageLookupByLibrary.simpleMessage("Bitiş"),
    "todoReminderNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Yapılacaklar hatırlatıcısı",
    ),
    "todoRemindersNeedUncheckedTodo": MessageLookupByLibrary.simpleMessage(
      "Hatırlatıcı ayarlamak için imleci yapılacak ögesinin üzerine getirin",
    ),
    "todoRemindersUnavailableInEncryptedNotes":
        MessageLookupByLibrary.simpleMessage(
          "Hatırlatıcılar şifreli notlarda kullanılamaz",
        ),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Çok fazla hatalı deneme, lütfen şifre ile giriş yapın",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Araç Çubuğu Konumu",
    ),
    "toolbarPositionBottom": MessageLookupByLibrary.simpleMessage("Alt"),
    "toolbarPositionTop": MessageLookupByLibrary.simpleMessage("En Üst"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Beklenmeyen bir hata oluştu",
    ),
    "unlockAction": MessageLookupByLibrary.simpleMessage("Kilidini Aç"),
    "unlockButton": MessageLookupByLibrary.simpleMessage("Kilidini Aç"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş notların kilidini aç",
    ),
    "unlockNoteAction": MessageLookupByLibrary.simpleMessage(
      "Notun kilidini aç",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Bu notun kilidini aç",
    ),
    "usePassphraseInstead": MessageLookupByLibrary.simpleMessage(
      "Bunun yerine parola kullanın",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "visitWebsite": MessageLookupByLibrary.simpleMessage(
      "Web sitemizi ziyaret edin",
    ),
    "webdavURL": MessageLookupByLibrary.simpleMessage("WebDAV URL\'si"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Yenilikler"),
    "whatsNewCloudBackupSubtitle": MessageLookupByLibrary.simpleMessage(
      "Hangi notların yedeklendiğini, yüklenmeyi beklediğini ve son senkronizasyonunuzun ne zaman gerçekleştiğini görün.",
    ),
    "whatsNewCloudBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Bulut yedekleme durumu",
    ),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Parola tabanlı şifreleme ve kurtarma seçenekleriyle hassas notları koruyun.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Şifreleme hakkında",
    ),
    "whatsNewHomeSearchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ana sayfadan notları bulun ve okurken bir notun içinde arama yapın.",
    ),
    "whatsNewHomeSearchTitle": MessageLookupByLibrary.simpleMessage(
      "Her yerde arama",
    ),
    "whatsNewStreakTrackingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Mevcut serinizi, en uzun serinizi, toplam kelimelerinizi ve 6 aylık etkinlik ısı haritanızı takip edin.",
    ),
    "whatsNewStreakTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Yazı çizgileri ve istatistikleri",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "DiaryVault\'u kendi renkleriniz ve görsel tarzınızla kişiselleştirin.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Tema oluşturma ve özelleştirme",
    ),
    "whatsNewTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Notların içine kontrol listeleri ekleyin, bağımsız yapılacaklar oluşturun ve hatırlatıcılarla bildirim alın.",
    ),
    "whatsNewTodosTitle": MessageLookupByLibrary.simpleMessage(
      "Hatırlatıcı içeren yapılacaklar",
    ),
    "writingActivity": MessageLookupByLibrary.simpleMessage("Yazma etkinliği"),
    "writingActivityEmpty": MessageLookupByLibrary.simpleMessage(
      "Yazma günleriniz burada gösterilecektir.",
    ),
    "writingActivityLess": MessageLookupByLibrary.simpleMessage("Az"),
    "writingActivityMore": MessageLookupByLibrary.simpleMessage("Daha fazla"),
    "writingActivityPeriod": MessageLookupByLibrary.simpleMessage("Son 6 ay"),
    "writingActivityPrivacyNote": MessageLookupByLibrary.simpleMessage(
      "Şifrelenmiş notlar bu istatistiklere dahil değildir.",
    ),
    "writingCurrentStreak": MessageLookupByLibrary.simpleMessage(
      "NAME OF TRANSLATORS",
    ),
    "writingDay": MessageLookupByLibrary.simpleMessage("gün"),
    "writingDays": MessageLookupByLibrary.simpleMessage("gün"),
    "writingLongestStreak": MessageLookupByLibrary.simpleMessage(
      "En Uzun Galibiyet Serisi:",
    ),
    "writingTotalWords": MessageLookupByLibrary.simpleMessage(
      "Toplam Sözcükler",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("Hatalı PIN"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Kaydedilmemiş değişiklikleriniz var",
    ),
    "youWillBeNotifiedAt": m4,
    "yourRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Kurtarma kodunuz",
    ),
  };
}
