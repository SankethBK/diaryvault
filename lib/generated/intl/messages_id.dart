// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  String get localeName => 'id';

  static String m0(imported, skipped, failed) =>
      "Catatan ${imported} yang diimpor, dilewati ${skipped} yang sudah ada, ${failed} gagal";

  static String m1(imported, skipped) =>
      "Mengimpor catatan ${imported}, melewatkan ${skipped} catatan yang sudah ada";

  static String m2(count) => "Mengimpor ${count} catatan";

  static String m3(minLength) =>
      "Frasa sandi harus setidaknya ${minLength} karakter";

  static String m4(time) => "Anda akan diberitahu pada ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("Aksen"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "Penyiapan akun berhasil",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Sudah memiliki akun?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Temukan diaryVault - aplikasi buku harian yang dirancang untuk membantu Anda menyimpan pikiran, kenangan, dan momen dengan mudah. Tersedia sekarang di Play Store!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("Bahasa Aplikasi"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Produk Susu Saya"),
    "appVersion": MessageLookupByLibrary.simpleMessage("Versi app"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "Apakah Anda yakin untuk logout?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage("Sinkron Otomatis"),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "Menyimpan catatan Anda secara otomatis setelah setiap 10 detik",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "Sinkronkan catatan secara otomatis dengan cloud",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "Platform tersedia untuk Sinkron",
    ),
    "backAction": MessageLookupByLibrary.simpleMessage("Kembali"),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "Dengan melanjutkan, Anda menyetujui kami",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("Kamera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Batal"),
    "change": MessageLookupByLibrary.simpleMessage("Ganti"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "Ubah warna latar belakang",
    ),
    "changeEmail": MessageLookupByLibrary.simpleMessage("Ganti Email"),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "Ubah frasa sandi enkripsi",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("Ubah gambar"),
    "changePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Ubah frasa sandi",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Ganti kata sandi"),
    "changeReminderTime": MessageLookupByLibrary.simpleMessage(
      "Ubah waktu pengingat",
    ),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage(
      "Pilih gambar latar belakang",
    ),
    "choosePassphraseHint": MessageLookupByLibrary.simpleMessage(
      "Anda akan memasukkan ini untuk membuka catatan terenkripsi. Gunakan sesuatu yang panjang dan berkesan.",
    ),
    "choosePassphraseTitle": MessageLookupByLibrary.simpleMessage(
      "Pilih frasa sandi",
    ),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage(
      "Pilih Sumber Sinkronisasi",
    ),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("Pilih Tema"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("PIlih waktu"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("Tutup aplikasi?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("Cadangan Cloud"),
    "confirmNewPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Konfirmasi frasa sandi baru",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Konfirmasi password baru",
    ),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage("Konfirmasi PIN"),
    "confirmPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Konfirmasi frasa sandi",
    ),
    "continueAsGues": MessageLookupByLibrary.simpleMessage(
      "Lanjutkan sebagai tamu",
    ),
    "continueButton": MessageLookupByLibrary.simpleMessage("Lanjutkan"),
    "copyButtonTooltip": MessageLookupByLibrary.simpleMessage("Salin"),
    "create": MessageLookupByLibrary.simpleMessage("Buat"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("Buat tema Anda"),
    "currentPassphraseIncorrect": MessageLookupByLibrary.simpleMessage(
      "Frasa sandi saat ini salah",
    ),
    "currentPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Frasa sandi saat ini",
    ),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "Pilih foto yang Anda sukai atau pilih warna latar belakang, dan kami akan membuat tema di sekitarnya.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("Tema kustom"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage("Pengingat Harian"),
    "darkLabel": MessageLookupByLibrary.simpleMessage("Gelap"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("Tema Gelap"),
    "dashboardAddTodo": MessageLookupByLibrary.simpleMessage("Tambahkan todo"),
    "dashboardAnotherPrompt": MessageLookupByLibrary.simpleMessage(
      "Prompt lain",
    ),
    "dashboardComingSoon": MessageLookupByLibrary.simpleMessage(
      "Segera datang",
    ),
    "dashboardCompletedTodos": MessageLookupByLibrary.simpleMessage("Selesai"),
    "dashboardCreateTodo": MessageLookupByLibrary.simpleMessage("Tambahkan"),
    "dashboardDailyPrompt": MessageLookupByLibrary.simpleMessage(
      "Prompt harian",
    ),
    "dashboardDailyPrompt1": MessageLookupByLibrary.simpleMessage(
      "Apa yang terasa seperti kemenangan kecil bagi saya hari ini?",
    ),
    "dashboardDailyPrompt2": MessageLookupByLibrary.simpleMessage(
      "Momen apa dari hari ini yang ingin saya ingat?",
    ),
    "dashboardDailyPrompt3": MessageLookupByLibrary.simpleMessage(
      "Apa yang membutuhkan lebih banyak energi daripada yang saya harapkan hari ini?",
    ),
    "dashboardDailyPrompt4": MessageLookupByLibrary.simpleMessage(
      "Apa yang bisa saya lepaskan malam ini?",
    ),
    "dashboardDailyPrompt5": MessageLookupByLibrary.simpleMessage(
      "Apa yang saya pelajari tentang diri saya hari ini?",
    ),
    "dashboardDailyPrompt6": MessageLookupByLibrary.simpleMessage(
      "Apa yang membuat hari saya sedikit lebih mudah?",
    ),
    "dashboardDailyPrompt7": MessageLookupByLibrary.simpleMessage(
      "Apa yang akan membuat hari esok terasa lebih lembut bagi saya?",
    ),
    "dashboardDailyPrompt8": MessageLookupByLibrary.simpleMessage(
      "Apa yang membuat saya merasa bersyukur hari ini?",
    ),
    "dashboardDueToday": MessageLookupByLibrary.simpleMessage(
      "Jatuh Tempo Hari Ini",
    ),
    "dashboardMoodCheckIn": MessageLookupByLibrary.simpleMessage("check-in"),
    "dashboardMoodContextPrompt": MessageLookupByLibrary.simpleMessage(
      "Ingin menambahkan sedikit konteks?",
    ),
    "dashboardMoodDifficult": MessageLookupByLibrary.simpleMessage(
      "Mengalami hari yang berat",
    ),
    "dashboardMoodGood": MessageLookupByLibrary.simpleMessage("Bagus"),
    "dashboardMoodGreat": MessageLookupByLibrary.simpleMessage("Hebat"),
    "dashboardMoodLow": MessageLookupByLibrary.simpleMessage("Tidak bagus"),
    "dashboardMoodNoteTitle": MessageLookupByLibrary.simpleMessage(
      "Renungan hari ini",
    ),
    "dashboardMoodOkay": MessageLookupByLibrary.simpleMessage("Iya"),
    "dashboardMoodOpeningDifficult": MessageLookupByLibrary.simpleMessage(
      "Hari ini adalah hari yang sulit.",
    ),
    "dashboardMoodOpeningGood": MessageLookupByLibrary.simpleMessage(
      "Hari ini, aku merasa baik.",
    ),
    "dashboardMoodOpeningGreat": MessageLookupByLibrary.simpleMessage(
      "Hari ini, aku merasa hebat.",
    ),
    "dashboardMoodOpeningLow": MessageLookupByLibrary.simpleMessage(
      "Hari ini, aku merasa tidak enak badan.",
    ),
    "dashboardMoodOpeningOkay": MessageLookupByLibrary.simpleMessage(
      "Hari ini, aku merasa baik - baik saja.",
    ),
    "dashboardMoodReflectionHint": MessageLookupByLibrary.simpleMessage(
      "Ada hal lain yang Anda pikirkan? (opsional)",
    ),
    "dashboardMoodSaveToJournal": MessageLookupByLibrary.simpleMessage(
      "Tambahkan ke catatan hari ini",
    ),
    "dashboardMoodSubtitle": MessageLookupByLibrary.simpleMessage(
      "Bagaimana perasaan Anda hari ini?",
    ),
    "dashboardNoDueDate": MessageLookupByLibrary.simpleMessage(
      "Tidak Ada Tanggal Jatuh Tempo",
    ),
    "dashboardNoTodos": MessageLookupByLibrary.simpleMessage(
      "Belum ada todos di sini",
    ),
    "dashboardNoTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tugas Anda yang terbuka dan selesai akan muncul di sini.",
    ),
    "dashboardOpenInNote": MessageLookupByLibrary.simpleMessage(
      "Buka dalam catatan",
    ),
    "dashboardOpenTodos": MessageLookupByLibrary.simpleMessage("Buka"),
    "dashboardOverdue": MessageLookupByLibrary.simpleMessage("Lewat tempo"),
    "dashboardPromptSubtitle": MessageLookupByLibrary.simpleMessage(
      "Pertanyaan kecil untuk direnungkan",
    ),
    "dashboardQuickCapture": MessageLookupByLibrary.simpleMessage(
      "Penangkapan cepat",
    ),
    "dashboardReminderOptional": MessageLookupByLibrary.simpleMessage(
      "Tidak ada pengingat yang ditetapkan",
    ),
    "dashboardSaveTodo": MessageLookupByLibrary.simpleMessage("Simpan"),
    "dashboardToday": MessageLookupByLibrary.simpleMessage("Hari ini"),
    "dashboardTodoLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat memuat todos",
    ),
    "dashboardTodoRequired": MessageLookupByLibrary.simpleMessage(
      "Masukkan todo terlebih dahulu",
    ),
    "dashboardTodoSourceHint": MessageLookupByLibrary.simpleMessage(
      "Todo dapat ditambahkan dari catatan atau dibuat langsung di sini.",
    ),
    "dashboardTodoTitle": MessageLookupByLibrary.simpleMessage(
      "Apa yang perlu dilakukan?",
    ),
    "dashboardTodoUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat memperbarui todo ini",
    ),
    "dashboardTodos": MessageLookupByLibrary.simpleMessage("Todos"),
    "dashboardUpcoming": MessageLookupByLibrary.simpleMessage("Akan datang"),
    "dashboardWriteAboutPrompt": MessageLookupByLibrary.simpleMessage(
      "Tuliskan tentang hal ini",
    ),
    "dateFilter": MessageLookupByLibrary.simpleMessage("Filter Tanggal"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("Tema Saya"),
    "delete": MessageLookupByLibrary.simpleMessage("Hapus"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage("Gagal menghapus"),
    "done": MessageLookupByLibrary.simpleMessage("Selesai"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Tidak punya akun?",
    ),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("Edit tema"),
    "editorPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Tulislah sesuatu di sini..",
    ),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Email berhasil diperbarui, silakan login kembali",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage(
      "Aktifkan simpan otomatis",
    ),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Aktifkan Pengingat Harian",
    ),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "Aktifkan login sidik jari",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage(
      "Aktifkan enkripsi catatan",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage(
      "Aktifkan login PIN",
    ),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Enkripsi catatan sensitif dengan frasa sandi yang hanya Anda ketahui. Catatan terenkripsi dilindungi pada perangkat ini dan di cadangan cloud Anda, dan berada dalam tampilan terkunci yang terpisah.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage(
      "Enkripsi catatan ini",
    ),
    "encryptYourNotesDescription": MessageLookupByLibrary.simpleMessage(
      "Catatan yang Anda tandai sebagai terenkripsi dilindungi di perangkat ini dan di cadangan cloud Anda dengan frasa sandi yang hanya Anda ketahui. Tidak ada orang lain - termasuk kami dan penyedia cloud Anda - yang dapat membacanya.",
    ),
    "encryptYourNotesTitle": MessageLookupByLibrary.simpleMessage(
      "Enkripsi catatan Anda",
    ),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Catatan terenkripsi",
    ),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "Catatan terenkripsi terkunci",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("Enkripsi"),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("Ya"),
    "encryptionEnabledToast": MessageLookupByLibrary.simpleMessage(
      "Enkripsi diaktifkan",
    ),
    "encryptionLossAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Saya mengerti tidak ada cara untuk memulihkan catatan saya jika saya lupa frasa sandi ini dan kehilangan kode pemulihan",
    ),
    "encryptionLossWarning": MessageLookupByLibrary.simpleMessage(
      "⚠️ Jika Anda lupa frasa sandi DAN kehilangan kode pemulihan, catatan terenkripsi akan hilang selamanya. Tidak ada cara untuk memulihkannya.",
    ),
    "encryptionSeparateViewDescription": MessageLookupByLibrary.simpleMessage(
      "Catatan terenkripsi berada dalam tampilan terkunci terpisah dan dikecualikan dari pencarian.",
    ),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "Siapkan frasa sandi dan kode pemulihan",
    ),
    "encryptionStaysOnToast": MessageLookupByLibrary.simpleMessage(
      "Enkripsi tetap aktif untuk catatan terenkripsi. Kunci kapan saja dari tampilan catatan terenkripsi.",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Masukkan Password Saat ini",
    ),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage(
      "Masukkan Email Baru",
    ),
    "enterPin": MessageLookupByLibrary.simpleMessage("Masukkan PIN Anda"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage(
      "Masukkan Email yang Terdaftar",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Ekspor catatan Anda"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("Ekspor ke JSON"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage("Ekspor ke PDF"),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage(
      "Ekspor ke Teks Biasa",
    ),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage(
      "Gagal mengambil catatan",
    ),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage(
      "Gagal menyimpan catatan",
    ),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage(
          "Otentikasi sidik jari harus diaktifkan di pengaturan perangkat",
        ),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage(
      "Login sidik jari gagal",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("Font Keluarga"),
    "forgotPassphraseUseRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Lupa frasa sandi? Gunakan kode pemulihan",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Lupa Kata Sandi"),
    "from": MessageLookupByLibrary.simpleMessage("Dari"),
    "gallery": MessageLookupByLibrary.simpleMessage("Galeri"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Dapatkan pengingat harian pada waktu yang Anda pilih agar jurnal Anda selalu terbarui.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "Impor dan Ekspor Catatan",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("Impor dari JSON"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage(
      "Frasa sandi salah",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Kata sandi salah",
    ),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Kode pemulihan salah.",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "File cadangan tidak valid",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Bahasa Indonesia"),
    "lastSynced": MessageLookupByLibrary.simpleMessage(
      "Terakhir disinkronkan: ",
    ),
    "leave": MessageLookupByLibrary.simpleMessage("Keluar"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("Lampu"),
    "link": MessageLookupByLibrary.simpleMessage("Link"),
    "lockAction": MessageLookupByLibrary.simpleMessage("Kunci"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Kunci catatan terenkripsi",
    ),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("Kunci catatan ini"),
    "logIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "logOut": MessageLookupByLibrary.simpleMessage("Keluar"),
    "logOut2": MessageLookupByLibrary.simpleMessage("Keluar"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "Silakan login untuk mengaktifkan sinkronisasi otomatis",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("Info Lainnya"),
    "muted": MessageLookupByLibrary.simpleMessage("Dibisukan"),
    "newPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "Frasa sandi baru",
    ),
    "newPassphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Frasa sandi baru tidak cocok",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Kata Sandi Baru"),
    "newRecoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Saya telah menuliskan kode baru",
    ),
    "newRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Tuliskan dan simpan dengan aman. Ini tidak akan ditampilkan lagi.",
    ),
    "newRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Kode pemulihan",
    ),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "Belum ada catatan terenkripsi",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Tidak tersedia"),
    "notNow": MessageLookupByLibrary.simpleMessage("Tidak sekarang"),
    "noteCollapsePreview": MessageLookupByLibrary.simpleMessage(
      "Ciutkan pratinjau",
    ),
    "noteDifferentPassphrase": MessageLookupByLibrary.simpleMessage(
      "Catatan ini dilindungi oleh frasa sandi yang berbeda",
    ),
    "noteExpandPreview": MessageLookupByLibrary.simpleMessage(
      "Perluas pratinjau",
    ),
    "noteNoTitle": MessageLookupByLibrary.simpleMessage("Catatan tanpa judul"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Catatan berhasil disimpan",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Catatan berhasil diubah",
    ),
    "noteWillBeSavedEncrypted": MessageLookupByLibrary.simpleMessage(
      "Catatan akan disimpan terenkripsi",
    ),
    "noteWillBeSavedUnencrypted": MessageLookupByLibrary.simpleMessage(
      "Catatan akan disimpan tanpa dienkripsi",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "Sinkron catatan berhasil",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "Luangkan beberapa menit untuk merenungkan hari Anda di buku harian Anda",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Anda belum memilih waktu notifikasi",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage(
      "Saatnya Membuat Jurnal!",
    ),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "Notifikasi tidak diaktifkan",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage(
      "Halaman tidak ditemukan",
    ),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "Palet (ketuk swatch untuk mengedit)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Frasa sandi"),
    "passphraseLabel": MessageLookupByLibrary.simpleMessage("Frasa sandi"),
    "passphraseMinLength": m3,
    "passphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Frasa sandi tidak cocok",
    ),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "Email pengaturan ulang kata sandi terkirim",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Pengaturan ulang kata sandi berhasil",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage(
      "Kata sandi diverifikasi",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Kata sandi tidak sesuai",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("Pilih Warna"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "Pilih warna latar belakang",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage(
      "Pilih Dari Berkas",
    ),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage("Gagal masuk"),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "PIN hingga 4 digit akan diminta di layar kunci",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage(
      "Masukkan PIN 4 digit baru",
    ),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Perasaan konfirmasi PIN",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage("PIN tidak cocok"),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage(
          "Silakan siapkan akun Anda untuk menggunakan fitur ini",
        ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Kebijakan Privasi"),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage("Proyek di Github"),
    "recordAudio": MessageLookupByLibrary.simpleMessage("Rekam suara"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage("Kode pemulihan"),
    "recoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "Saya telah menuliskan kode pemulihan saya",
    ),
    "recoveryCodeCopiedToast": MessageLookupByLibrary.simpleMessage(
      "Kode pemulihan disalin",
    ),
    "recoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Tuliskan ini dan simpan di tempat yang aman. Ini adalah SATU - SATUNYA cara untuk memulihkan catatan Anda jika Anda lupa frasa sandi. Ini tidak akan ditampilkan lagi.",
    ),
    "regenerateButton": MessageLookupByLibrary.simpleMessage("Buat Lagi"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "Buat ulang kode pemulihan",
    ),
    "regenerateRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "Ini membatalkan kode pemulihan lama Anda. Masukkan frasa sandi Anda untuk melanjutkan.",
    ),
    "reminderRemoved": MessageLookupByLibrary.simpleMessage(
      "Pengingat dihapus",
    ),
    "reminderSchedulingFailed": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat menjadwalkan pengingat. Silakan coba lagi.",
    ),
    "reminderSet": MessageLookupByLibrary.simpleMessage("Set pengingat"),
    "reminderTimeMustBeInFuture": MessageLookupByLibrary.simpleMessage(
      "Silakan pilih waktu di masa mendatang",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("Pengingat"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "Hapus enkripsi dari catatan ini",
    ),
    "removeReminder": MessageLookupByLibrary.simpleMessage("Hapus pengingat"),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Atur ulang kata sandi",
    ),
    "resetPin": MessageLookupByLibrary.simpleMessage("Atur Ulang PIN"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage(
      "Simpan & terapkan tema",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Simpan perubahan"),
    "searchInNoteHint": MessageLookupByLibrary.simpleMessage("Cari di catatan"),
    "security": MessageLookupByLibrary.simpleMessage("Keamanan"),
    "securityBackedUpNotes": MessageLookupByLibrary.simpleMessage(
      "Dicadangkan",
    ),
    "securityBackupNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Pilih penyedia cadangan cloud untuk melihat statistik cadangan.",
    ),
    "securityBackupOffline": MessageLookupByLibrary.simpleMessage(
      "Status cadangan tidak tersedia secara offline.",
    ),
    "securityBackupSetupHint": MessageLookupByLibrary.simpleMessage(
      "Aktifkan pencadangan cloud sehingga Anda tidak pernah kehilangan catatan.",
    ),
    "securityBackupSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Menyiapkan cadangan baru",
    ),
    "securityBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Privasi & cadangan",
    ),
    "securityBackupUnverified": MessageLookupByLibrary.simpleMessage(
      "Sinkronkan satu kali untuk memverifikasi status cadangan Anda.",
    ),
    "securityEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Catatan terenkripsi",
    ),
    "securityLastSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi terakhir yang berhasil",
    ),
    "securityLastSync": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi Terakhir: ",
    ),
    "securityMetricUnavailable": MessageLookupByLibrary.simpleMessage(
      "Tidak tersedia",
    ),
    "securityNoSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "Belum ada sinkronisasi yang berhasil.",
    ),
    "securityPendingBackup": MessageLookupByLibrary.simpleMessage(
      "Membutuhkan pencadangan",
    ),
    "securitySettings": MessageLookupByLibrary.simpleMessage("Keamanan"),
    "securityStatsNotConfigured": MessageLookupByLibrary.simpleMessage(
      "Anda belum memilih platform cadangan cloud.",
    ),
    "securitySyncedData": MessageLookupByLibrary.simpleMessage("Data cloud"),
    "select": MessageLookupByLibrary.simpleMessage("Pilih"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("Pilih Suara"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("Kirim masukan"),
    "setPassphrase": MessageLookupByLibrary.simpleMessage("Atur frasa sandi"),
    "setTodoReminder": MessageLookupByLibrary.simpleMessage(
      "Atur pengingat tugas",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage(
      "Siapkan Akun Anda",
    ),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage(
      "Bagikan kepada Teman",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Masuk"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage(
      "Masuk dengan Email",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Daftar"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("Masuk sebagai"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage(
      "Urutkan berdasarkan A-Z",
    ),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage(
      "Urutkan berdasarkan Terbaru Terlebih Dahulu",
    ),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage(
      "Urutkan berdasarkan Terlama Terlebih Dahulu",
    ),
    "stay": MessageLookupByLibrary.simpleMessage("Tinggal"),
    "submit": MessageLookupByLibrary.simpleMessage("Kirim"),
    "syncNow": MessageLookupByLibrary.simpleMessage("Sinkron sekarang"),
    "syncSourceNone": MessageLookupByLibrary.simpleMessage("Tidak Ada"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage("sudah ada"),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage(
      "Ketuk untuk perluas judul",
    ),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "Sesuaikan Tema, Font, dan Bahasa",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("Nama tema"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("Tema Saya"),
    "to": MessageLookupByLibrary.simpleMessage("Ke"),
    "todoReminderNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Pengingat tugas",
    ),
    "todoRemindersNeedUncheckedTodo": MessageLookupByLibrary.simpleMessage(
      "Tempatkan kursor pada item yang harus dilakukan untuk mengatur pengingat",
    ),
    "todoRemindersUnavailableInEncryptedNotes":
        MessageLookupByLibrary.simpleMessage(
          "Pengingat tidak tersedia dalam catatan terenkripsi",
        ),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "Terlalu banyak kesalahan, silahkan login dengan kata sandi",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage(
      "Posisi Bilah Alat",
    ),
    "toolbarPositionBottom": MessageLookupByLibrary.simpleMessage("Bawah"),
    "toolbarPositionTop": MessageLookupByLibrary.simpleMessage("Teratas"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "Terjadi kesalahan tak terduga",
    ),
    "unlockAction": MessageLookupByLibrary.simpleMessage("Buka Kunci"),
    "unlockButton": MessageLookupByLibrary.simpleMessage("Buka Kunci"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "Buka catatan terenkripsi",
    ),
    "unlockNoteAction": MessageLookupByLibrary.simpleMessage(
      "Buka kunci catatan",
    ),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage(
      "Buka kunci catatan ini",
    ),
    "usePassphraseInstead": MessageLookupByLibrary.simpleMessage(
      "Gunakan frasa sandi saja",
    ),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "visitWebsite": MessageLookupByLibrary.simpleMessage(
      "Kunjungi situs web kami",
    ),
    "webdavURL": MessageLookupByLibrary.simpleMessage("URL WebDAV"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("Apa yang baru?"),
    "whatsNewCloudBackupSubtitle": MessageLookupByLibrary.simpleMessage(
      "Lihat catatan mana yang dicadangkan, menunggu unggahan, dan kapan sinkronisasi terakhir Anda terjadi.",
    ),
    "whatsNewCloudBackupTitle": MessageLookupByLibrary.simpleMessage(
      "Status cadangan cloud",
    ),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Lindungi catatan sensitif dengan enkripsi berbasis frasa sandi dan opsi pemulihan.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage(
      "Tentang enkripsi",
    ),
    "whatsNewHomeSearchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Temukan catatan dari halaman beranda dan cari di dalam catatan saat membaca.",
    ),
    "whatsNewHomeSearchTitle": MessageLookupByLibrary.simpleMessage(
      "Cari dimana saja!",
    ),
    "whatsNewStreakTrackingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Lacak rentetan Anda saat ini, rentetan terpanjang, total kata, dan peta panas aktivitas 6 bulan.",
    ),
    "whatsNewStreakTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Menulis coretan & statistik",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Personalisasi DiaryVault dengan warna dan gaya visual Anda sendiri.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "Membuat dan menyesuaikan tema",
    ),
    "whatsNewTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tambahkan daftar periksa di dalam catatan, buat todos mandiri, dan dapatkan pemberitahuan dengan pengingat.",
    ),
    "whatsNewTodosTitle": MessageLookupByLibrary.simpleMessage(
      "Todo dengan pengingat",
    ),
    "writingActivity": MessageLookupByLibrary.simpleMessage("Kegiatan menulis"),
    "writingActivityEmpty": MessageLookupByLibrary.simpleMessage(
      "Hari penulisan Anda akan ditampilkan di sini.",
    ),
    "writingActivityLess": MessageLookupByLibrary.simpleMessage(
      "Lebih sedikit",
    ),
    "writingActivityMore": MessageLookupByLibrary.simpleMessage("Lainnya"),
    "writingActivityPeriod": MessageLookupByLibrary.simpleMessage(
      "6 bulan terakhir",
    ),
    "writingActivityPrivacyNote": MessageLookupByLibrary.simpleMessage(
      "Catatan terenkripsi tidak termasuk dalam statistik ini.",
    ),
    "writingCurrentStreak": MessageLookupByLibrary.simpleMessage(
      "Beruntun saat ini",
    ),
    "writingDay": MessageLookupByLibrary.simpleMessage("hari"),
    "writingDays": MessageLookupByLibrary.simpleMessage("hari"),
    "writingLongestStreak": MessageLookupByLibrary.simpleMessage(
      "Kemenangan Beruntun terpanjang:",
    ),
    "writingTotalWords": MessageLookupByLibrary.simpleMessage(
      "Total kata: 1619",
    ),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("PIN SALAH"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "Anda memiliki perubahan yang belum disimpan",
    ),
    "youWillBeNotifiedAt": m4,
    "yourRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Kode pemulihan",
    ),
  };
}
