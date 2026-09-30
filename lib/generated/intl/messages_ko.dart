// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(imported, skipped, failed) =>
      "가져온 ${imported} 메모, ${skipped} 기존 항목 건너뜀, ${failed} 실패";

  static String m1(imported, skipped) =>
      "가져온 ${imported} 메모, 기존 메모 ${skipped} 건너뜀";

  static String m2(count) => "가져온 메모 ${count} 개";

  static String m3(minLength) => "암호는 ${minLength} 자 이상이어야 합니다";

  static String m4(time) => "알림 시간: ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accent": MessageLookupByLibrary.simpleMessage("강조"),
    "accountSetupSuccessful": MessageLookupByLibrary.simpleMessage(
      "계정 설정이 완료되었습니다",
    ),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "이미 계정이 있습니까?",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "DiaryVault를 만나보세요 - 생각, 추억, 순간을 손쉽게 기록할 수 있는 다이어리 앱입니다. 지금 Play 스토어에서 사용해보세요!",
    ),
    "appLanguage": MessageLookupByLibrary.simpleMessage("앱 언어"),
    "appTitle": MessageLookupByLibrary.simpleMessage("나의 유제품"),
    "appVersion": MessageLookupByLibrary.simpleMessage("앱 버전"),
    "areYouSureAboutLoggingOut": MessageLookupByLibrary.simpleMessage(
      "정말 로그아웃하시겠습니까?",
    ),
    "autoSync": MessageLookupByLibrary.simpleMessage("자동 동기화"),
    "automaticallySave": MessageLookupByLibrary.simpleMessage(
      "10초마다 자동으로 노트를 저장합니다",
    ),
    "automaticallySyncNotesWithCloud": MessageLookupByLibrary.simpleMessage(
      "클라우드와 노트 자동 동기화",
    ),
    "availablePlatformsForSync": MessageLookupByLibrary.simpleMessage(
      "사용 가능한 동기화 플랫폼",
    ),
    "backAction": MessageLookupByLibrary.simpleMessage("뒤로"),
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "계속 진행함으로써 다음에 동의합니다:",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("카메라"),
    "cancel": MessageLookupByLibrary.simpleMessage("취소"),
    "change": MessageLookupByLibrary.simpleMessage("변경"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage("배경색 변경..."),
    "changeEmail": MessageLookupByLibrary.simpleMessage("이메일 변경"),
    "changeEncryptionPassphrase": MessageLookupByLibrary.simpleMessage(
      "암호화 암호 변경",
    ),
    "changeImage": MessageLookupByLibrary.simpleMessage("이미지 변경"),
    "changePassphraseTitle": MessageLookupByLibrary.simpleMessage("암호 바꾸기..."),
    "changePassword": MessageLookupByLibrary.simpleMessage("비밀번호 변경"),
    "changeReminderTime": MessageLookupByLibrary.simpleMessage("알림 시간 변경"),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage("배경 이미지 선택"),
    "choosePassphraseHint": MessageLookupByLibrary.simpleMessage(
      "암호화된 메모의 잠금을 해제하려면 이 값을 입력합니다. 길고 기억에 남는 것을 사용하세요.",
    ),
    "choosePassphraseTitle": MessageLookupByLibrary.simpleMessage("암호 선택"),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage("동기화 소스 선택"),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("테마 선택"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("시간 선택"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("앱을 종료하시겠습니까?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("클라우드 백업"),
    "confirmNewPassphraseLabel": MessageLookupByLibrary.simpleMessage(
      "새 암호 확인",
    ),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage("새 비밀번호 확인"),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage("새 PIN 확인"),
    "confirmPassphraseLabel": MessageLookupByLibrary.simpleMessage("암호 확인"),
    "continueAsGues": MessageLookupByLibrary.simpleMessage("게스트로 계속하기"),
    "continueButton": MessageLookupByLibrary.simpleMessage("계속하기"),
    "copyButtonTooltip": MessageLookupByLibrary.simpleMessage("복사"),
    "create": MessageLookupByLibrary.simpleMessage("생성"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("테마 만들기"),
    "currentPassphraseIncorrect": MessageLookupByLibrary.simpleMessage(
      "현재 암호가 올바르지 않습니다",
    ),
    "currentPassphraseLabel": MessageLookupByLibrary.simpleMessage("현재 암호"),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "마음에 드는 사진을 선택하거나 배경색을 선택하면 테마를 만들 수 있습니다.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("사용자 정의 테마"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage("일일 알림"),
    "darkLabel": MessageLookupByLibrary.simpleMessage("다크"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("어두운 테마"),
    "dashboardAddTodo": MessageLookupByLibrary.simpleMessage("할 일 추가"),
    "dashboardAnotherPrompt": MessageLookupByLibrary.simpleMessage("또 다른 프롬프트"),
    "dashboardComingSoon": MessageLookupByLibrary.simpleMessage("출시 예정"),
    "dashboardCompletedTodos": MessageLookupByLibrary.simpleMessage("완료됨"),
    "dashboardCreateTodo": MessageLookupByLibrary.simpleMessage("추가"),
    "dashboardDailyPrompt": MessageLookupByLibrary.simpleMessage("일일 안내"),
    "dashboardDailyPrompt1": MessageLookupByLibrary.simpleMessage(
      "오늘 내가 작은 승리를 거둔 기분은 무엇이었을까?",
    ),
    "dashboardDailyPrompt2": MessageLookupByLibrary.simpleMessage(
      "나는 오늘부터 어떤 순간을 기억하고 싶은가?",
    ),
    "dashboardDailyPrompt3": MessageLookupByLibrary.simpleMessage(
      "오늘 기대했던 것보다 더 많은 에너지가 필요했던 것은 무엇이었을까요?",
    ),
    "dashboardDailyPrompt4": MessageLookupByLibrary.simpleMessage(
      "오늘 밤 무엇을 놓을 수 있을까?",
    ),
    "dashboardDailyPrompt5": MessageLookupByLibrary.simpleMessage(
      "오늘 나 자신에 대해 무엇을 배웠는가?",
    ),
    "dashboardDailyPrompt6": MessageLookupByLibrary.simpleMessage(
      "무엇이 제 하루를 조금 더 편하게 해주었나요?",
    ),
    "dashboardDailyPrompt7": MessageLookupByLibrary.simpleMessage(
      "내일이 나에게 더 온화하게 느껴지는 것은 무엇인가?",
    ),
    "dashboardDailyPrompt8": MessageLookupByLibrary.simpleMessage(
      "오늘 감사한 마음을 갖게 된 계기는 무엇인가요?",
    ),
    "dashboardDueToday": MessageLookupByLibrary.simpleMessage("오늘 마감"),
    "dashboardEditTodo": MessageLookupByLibrary.simpleMessage("할 일 편집"),
    "dashboardMoodCheckIn": MessageLookupByLibrary.simpleMessage("체크인"),
    "dashboardMoodContextPrompt": MessageLookupByLibrary.simpleMessage(
      "맥락을 조금 더 추가하고 싶으신가요?",
    ),
    "dashboardMoodDifficult": MessageLookupByLibrary.simpleMessage("힘든 하루 보내기"),
    "dashboardMoodGood": MessageLookupByLibrary.simpleMessage("뛰어남"),
    "dashboardMoodGreat": MessageLookupByLibrary.simpleMessage("훌륭해요"),
    "dashboardMoodLow": MessageLookupByLibrary.simpleMessage("좋지 않음"),
    "dashboardMoodNoteTitle": MessageLookupByLibrary.simpleMessage("오늘의 성찰"),
    "dashboardMoodOkay": MessageLookupByLibrary.simpleMessage("확인"),
    "dashboardMoodOpeningDifficult": MessageLookupByLibrary.simpleMessage(
      "오늘은 정말 힘든 날이었어요.",
    ),
    "dashboardMoodOpeningGood": MessageLookupByLibrary.simpleMessage(
      "오늘은 기분이 좋다.",
    ),
    "dashboardMoodOpeningGreat": MessageLookupByLibrary.simpleMessage(
      "오늘은 기분이 좋아.",
    ),
    "dashboardMoodOpeningLow": MessageLookupByLibrary.simpleMessage(
      "오늘은 기분이 좋지 않아요.",
    ),
    "dashboardMoodOpeningOkay": MessageLookupByLibrary.simpleMessage(
      "오늘은 괜찮아.",
    ),
    "dashboardMoodReflectionHint": MessageLookupByLibrary.simpleMessage(
      "기타 궁금하신 사항이 있나요? (선택사항)",
    ),
    "dashboardMoodSaveToJournal": MessageLookupByLibrary.simpleMessage(
      "오늘의 메모에 추가",
    ),
    "dashboardMoodSubtitle": MessageLookupByLibrary.simpleMessage(
      "오늘 몸 상태는 어떤가?”",
    ),
    "dashboardNoDueDate": MessageLookupByLibrary.simpleMessage("기한 없음"),
    "dashboardNoTodos": MessageLookupByLibrary.simpleMessage(
      "아직 여기에 할 일이 없습니다",
    ),
    "dashboardNoTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "진행 중인 작업과 완료된 작업이 여기에 표시됩니다.",
    ),
    "dashboardOpenInNote": MessageLookupByLibrary.simpleMessage("메모에서 열기"),
    "dashboardOpenTodos": MessageLookupByLibrary.simpleMessage("열기"),
    "dashboardOverdue": MessageLookupByLibrary.simpleMessage("기한 초과"),
    "dashboardPromptSubtitle": MessageLookupByLibrary.simpleMessage(
      "돌이켜 봐야 할 작은 질문",
    ),
    "dashboardQuickCapture": MessageLookupByLibrary.simpleMessage("빠른 캡처"),
    "dashboardReminderOptional": MessageLookupByLibrary.simpleMessage("알림 없음"),
    "dashboardSaveTodo": MessageLookupByLibrary.simpleMessage("저장"),
    "dashboardToday": MessageLookupByLibrary.simpleMessage("오늘"),
    "dashboardTodoLoadFailed": MessageLookupByLibrary.simpleMessage(
      "할 일을 로드할 수 없습니다",
    ),
    "dashboardTodoRequired": MessageLookupByLibrary.simpleMessage(
      "할 일을 먼저 입력하세요",
    ),
    "dashboardTodoSourceHint": MessageLookupByLibrary.simpleMessage(
      "할 일은 메모에서 추가하거나 여기에서 직접 생성할 수 있습니다.",
    ),
    "dashboardTodoTitle": MessageLookupByLibrary.simpleMessage(
      "어떤 조치가 필요하신가요?",
    ),
    "dashboardTodoUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "이 할 일을 업데이트할 수 없습니다",
    ),
    "dashboardTodos": MessageLookupByLibrary.simpleMessage("할 일"),
    "dashboardUpcoming": MessageLookupByLibrary.simpleMessage("다음 경기"),
    "dashboardWriteAboutPrompt": MessageLookupByLibrary.simpleMessage(
      "이에 대해 작성하세요.",
    ),
    "dateFilter": MessageLookupByLibrary.simpleMessage("날짜 필터"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("고유 주제"),
    "delete": MessageLookupByLibrary.simpleMessage("삭제"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage("삭제 실패"),
    "done": MessageLookupByLibrary.simpleMessage("완료"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("계정이 없으신가요?"),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("테마 수정"),
    "editorPlaceholder": MessageLookupByLibrary.simpleMessage("쓰기..."),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "이메일이 성공적으로 업데이트되었습니다, 로그인 해주세요",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage("자동 저장 활성화"),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage("일일 알림 활성화"),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "지문 로그인 활성화",
    ),
    "enableNoteEncryption": MessageLookupByLibrary.simpleMessage("메모 암호화 활성화"),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage("PIN 로그인 활성화"),
    "encryptSensitiveNotesDescription": MessageLookupByLibrary.simpleMessage(
      "나만 아는 암호로 민감한 메모를 암호화하세요. 암호화된 메모는 이 장치와 클라우드 백업에서 보호되며 별도의 잠긴 보기에서 사용할 수 있습니다.",
    ),
    "encryptThisNote": MessageLookupByLibrary.simpleMessage("이 메모 암호화"),
    "encryptYourNotesDescription": MessageLookupByLibrary.simpleMessage(
      "암호화된 것으로 표시된 메모는 이 장치와 클라우드 백업에서 사용자만 아는 암호로 보호됩니다. 당사와 클라우드 제공업체를 포함한 다른 누구도 읽을 수 없습니다.",
    ),
    "encryptYourNotesTitle": MessageLookupByLibrary.simpleMessage("메모 암호화"),
    "encryptedNotes": MessageLookupByLibrary.simpleMessage("암호화된 메모"),
    "encryptedNotesLocked": MessageLookupByLibrary.simpleMessage(
      "암호화된 메모가 잠겨 있습니다",
    ),
    "encryption": MessageLookupByLibrary.simpleMessage("암호화 "),
    "encryptionEnabled": MessageLookupByLibrary.simpleMessage("활성화됨"),
    "encryptionEnabledToast": MessageLookupByLibrary.simpleMessage("암호화 활성화됨"),
    "encryptionLossAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "이 암호를 잊어버리고 복구 코드를 분실한 경우 메모를 복구할 수 있는 방법이 없음을 이해합니다.",
    ),
    "encryptionLossWarning": MessageLookupByLibrary.simpleMessage(
      "⚠️ 암호를 잊어버리고 복구 코드를 분실하면 암호화된 메모는 영원히 사라집니다. 복구할 방법이 없습니다.",
    ),
    "encryptionSeparateViewDescription": MessageLookupByLibrary.simpleMessage(
      "암호화된 메모는 별도의 잠긴 보기에 저장되며 검색에서 제외됩니다.",
    ),
    "encryptionSetupPrompt": MessageLookupByLibrary.simpleMessage(
      "암호 및 복구 코드 설정",
    ),
    "encryptionStaysOnToast": MessageLookupByLibrary.simpleMessage(
      "암호화된 메모에 대한 암호화가 켜져 있습니다. 암호화된 메모 보기에서 언제든지 잠글 수 있습니다.",
    ),
    "enterCurrentPassword": MessageLookupByLibrary.simpleMessage("현재 비밀번호 입력"),
    "enterNewEmail": MessageLookupByLibrary.simpleMessage("새 메일 입력"),
    "enterPin": MessageLookupByLibrary.simpleMessage("PIN 입력"),
    "enterRegisteredEmail": MessageLookupByLibrary.simpleMessage("등록된 메일 입력"),
    "exportNotes": MessageLookupByLibrary.simpleMessage("노트 내보내기"),
    "exportToJSON": MessageLookupByLibrary.simpleMessage("JSON으로 내보내기"),
    "exportToPDF": MessageLookupByLibrary.simpleMessage("PDF로 내보내기"),
    "exportToPlainText": MessageLookupByLibrary.simpleMessage("일반 텍스트로 내보내기"),
    "failedToFetchNote": MessageLookupByLibrary.simpleMessage("노트를 가져오지 못했습니다"),
    "failedToSaveNote": MessageLookupByLibrary.simpleMessage("노트 저장에 실패했습니다"),
    "fingerPrintAthShouldBeEnabledInDeviceSettings":
        MessageLookupByLibrary.simpleMessage("지문 인증은 기기 설정에서 활성화되어야 합니다"),
    "fingerprintLoginFailed": MessageLookupByLibrary.simpleMessage("지문 로그인 실패"),
    "fontFamily": MessageLookupByLibrary.simpleMessage("글꼴"),
    "forgotPassphraseUseRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "암호를 잊으셨나요? 복구 코드를 사용하세요",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("비밀번호 찾기"),
    "from": MessageLookupByLibrary.simpleMessage("시작일"),
    "gallery": MessageLookupByLibrary.simpleMessage("갤러리"),
    "getDailyReminders": MessageLookupByLibrary.simpleMessage(
      "선택한 시간에 매일 알림을 받아 일기를 꾸준히 작성하세요.",
    ),
    "googleDrive": MessageLookupByLibrary.simpleMessage("Google Drive"),
    "importAndExportNotes": MessageLookupByLibrary.simpleMessage(
      "노트 가져오기 및 내보내기",
    ),
    "importFromJSON": MessageLookupByLibrary.simpleMessage("가져오기"),
    "incorrectPassphrase": MessageLookupByLibrary.simpleMessage("잘못된 암호"),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage("잘못된 비밀번호"),
    "incorrectRecoveryCode": MessageLookupByLibrary.simpleMessage(
      "유효하지 않은 복구 코드.",
    ),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("유효하지 않은 백업 파일"),
    "language": MessageLookupByLibrary.simpleMessage("Korean"),
    "lastSynced": MessageLookupByLibrary.simpleMessage("마지막 동기화: "),
    "leave": MessageLookupByLibrary.simpleMessage("나가기"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("라이트"),
    "link": MessageLookupByLibrary.simpleMessage("링크"),
    "lockAction": MessageLookupByLibrary.simpleMessage("잠금 장치"),
    "lockEncryptedNotes": MessageLookupByLibrary.simpleMessage("암호화된 메모 잠금"),
    "lockThisNote": MessageLookupByLibrary.simpleMessage("이 메모 잠그기"),
    "logIn": MessageLookupByLibrary.simpleMessage("로그인"),
    "logOut": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "logOut2": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "자동 동기화를 사용하려면 로그인하세요",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("자세히 보기"),
    "muted": MessageLookupByLibrary.simpleMessage("뮤트 중"),
    "newPassphraseLabel": MessageLookupByLibrary.simpleMessage("새 암호"),
    "newPassphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "새 암호가 일치하지 않습니다",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("새 비밀번호"),
    "newRecoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "새 코드를 적어 두었습니다.",
    ),
    "newRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "적어두고 안전하게 보관하세요. 다시 표시되지 않습니다.",
    ),
    "newRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage("복구 코드"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "noEncryptedNotesYet": MessageLookupByLibrary.simpleMessage(
      "아직 암호화된 메모가 없습니다",
    ),
    "notAvailable": MessageLookupByLibrary.simpleMessage("사용 불가"),
    "notNow": MessageLookupByLibrary.simpleMessage(""),
    "noteCollapsePreview": MessageLookupByLibrary.simpleMessage("미리보기 접기"),
    "noteDifferentPassphrase": MessageLookupByLibrary.simpleMessage(
      "이 메모는 다른 암호로 보호됩니다",
    ),
    "noteExpandPreview": MessageLookupByLibrary.simpleMessage("미리보기 펼치기"),
    "noteNoTitle": MessageLookupByLibrary.simpleMessage("제목 없는 메모"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "노트가 성공적으로 저장되었습니다",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "노트가 성공적으로 업데이트되었습니다",
    ),
    "noteWillBeSavedEncrypted": MessageLookupByLibrary.simpleMessage(
      "메모는 암호화되어 저장됩니다",
    ),
    "noteWillBeSavedUnencrypted": MessageLookupByLibrary.simpleMessage(
      "메모는 암호화되지 않은 상태로 저장됩니다",
    ),
    "notesImportPartialFailure": m0,
    "notesImportSkippedSummary": m1,
    "notesImportSuccess": m2,
    "notesSyncSuccessfull": MessageLookupByLibrary.simpleMessage(
      "노트 동기화가 성공적으로 완료되었습니다",
    ),
    "notificationDescription1": MessageLookupByLibrary.simpleMessage(
      "오늘 하루를 되돌아보며 다이어리에 기록해보세요",
    ),
    "notificationTimeNotEnabled": MessageLookupByLibrary.simpleMessage(
      "알림 시간을 선택하지 않았습니다",
    ),
    "notificationTitle1": MessageLookupByLibrary.simpleMessage("일기 작성 시간입니다!"),
    "notificationsNotEnabled": MessageLookupByLibrary.simpleMessage(
      "알림이 활성화되어 있지 않습니다",
    ),
    "pageNotFound": MessageLookupByLibrary.simpleMessage("페이지를 찾을 수 없습니다"),
    "paletteInstruction": MessageLookupByLibrary.simpleMessage(
      "팔레트 (견본을 탭하여 수정)",
    ),
    "passphrase": MessageLookupByLibrary.simpleMessage("Passphrase"),
    "passphraseLabel": MessageLookupByLibrary.simpleMessage("Passphrase"),
    "passphraseMinLength": m3,
    "passphrasesDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "암호가 일치하지 않습니다",
    ),
    "passwordResetMailSent": MessageLookupByLibrary.simpleMessage(
      "비밀번호 초기화 메일이 전송되었습니다",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "비밀번호가 성공적으로 초기화 되었습니다",
    ),
    "passwordVerified": MessageLookupByLibrary.simpleMessage("비밀번호 확인됨"),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "비밀번호가 일치하지 않습니다",
    ),
    "pickAColor": MessageLookupByLibrary.simpleMessage("색상 선택"),
    "pickBackgroundColorInstead": MessageLookupByLibrary.simpleMessage(
      "대신 배경색 선택",
    ),
    "pickFromFileManager": MessageLookupByLibrary.simpleMessage("파일에서 선택"),
    "pinLoginFailed": MessageLookupByLibrary.simpleMessage("PIN 로그인 실패"),
    "pinLoginSetupInstructions": MessageLookupByLibrary.simpleMessage(
      "잠금 화면에서 4자리 PIN 입력을 요청합니다",
    ),
    "pinMustBe4Digit": MessageLookupByLibrary.simpleMessage("4자리 PIN을 입력하세요"),
    "pinResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "PIN이 성공적으로 재설정되었습니다",
    ),
    "pinsDontMatch": MessageLookupByLibrary.simpleMessage("PIN이 일치하지 않습니다"),
    "pleaseSetupYourAccountToUseThisFeature":
        MessageLookupByLibrary.simpleMessage("이 기능을 사용하려면 계정을 설정하세요"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("개인정보 처리방침"),
    "projectOnGithub": MessageLookupByLibrary.simpleMessage("GitHub에서 프로젝트 보기"),
    "recordAudio": MessageLookupByLibrary.simpleMessage("오디오 녹음"),
    "recoveryCode": MessageLookupByLibrary.simpleMessage("복구 코드"),
    "recoveryCodeAcknowledgement": MessageLookupByLibrary.simpleMessage(
      "복구 코드를 적었습니다.",
    ),
    "recoveryCodeCopiedToast": MessageLookupByLibrary.simpleMessage(
      "복구 코드 복사 완료",
    ),
    "recoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "이것을 적어서 안전한 곳에 보관하십시오. 암호를 잊은 경우 메모를 복구하는 유일한 방법입니다. 다시 표시되지 않습니다.",
    ),
    "regenerateButton": MessageLookupByLibrary.simpleMessage("재생성"),
    "regenerateRecoveryCode": MessageLookupByLibrary.simpleMessage("복구 코드 재생성"),
    "regenerateRecoveryCodeDescription": MessageLookupByLibrary.simpleMessage(
      "이렇게 하면 이전 복구 코드가 무효화됩니다. 계속하려면 비밀번호를 입력하세요.",
    ),
    "reminderRemoved": MessageLookupByLibrary.simpleMessage("리마인더 제거됨"),
    "reminderSchedulingFailed": MessageLookupByLibrary.simpleMessage(
      "미리 알림을 예약할 수 없습니다. 다시 시도해주세요.",
    ),
    "reminderSet": MessageLookupByLibrary.simpleMessage("알림 설정"),
    "reminderTimeMustBeInFuture": MessageLookupByLibrary.simpleMessage(
      "미래의 시간을 선택하세요",
    ),
    "reminders": MessageLookupByLibrary.simpleMessage("알림"),
    "removeEncryptionFromThisNote": MessageLookupByLibrary.simpleMessage(
      "이 메모에서 암호화 제거",
    ),
    "removeReminder": MessageLookupByLibrary.simpleMessage("리마인더 삭제"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("비밀번호 초기화"),
    "resetPin": MessageLookupByLibrary.simpleMessage("PIN 재설정"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage("테마 저장 및 적용"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("변경 사항 저장"),
    "searchInNoteHint": MessageLookupByLibrary.simpleMessage("검색 범위"),
    "security": MessageLookupByLibrary.simpleMessage("보안"),
    "securityBackedUpNotes": MessageLookupByLibrary.simpleMessage("백업 "),
    "securityBackupNotConfigured": MessageLookupByLibrary.simpleMessage(
      "백업 통계를 보려면 클라우드 백업 공급자를 선택하십시오.",
    ),
    "securityBackupOffline": MessageLookupByLibrary.simpleMessage(
      "백업 상태를 오프라인에서 사용할 수 없습니다.",
    ),
    "securityBackupSetupHint": MessageLookupByLibrary.simpleMessage(
      "노트를 잃지 않도록 클라우드 백업을 활성화하세요.",
    ),
    "securityBackupSetupTitle": MessageLookupByLibrary.simpleMessage("백업 설정"),
    "securityBackupTitle": MessageLookupByLibrary.simpleMessage(
      "개인 정보 보호 및 백업",
    ),
    "securityBackupUnverified": MessageLookupByLibrary.simpleMessage(
      "백업 상태를 확인하려면 한 번 동기화하세요.",
    ),
    "securityEncryptedNotes": MessageLookupByLibrary.simpleMessage("암호화된 메모"),
    "securityLastSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "마지막 동기화 성공",
    ),
    "securityLastSync": MessageLookupByLibrary.simpleMessage("마지막 동기화"),
    "securityMetricUnavailable": MessageLookupByLibrary.simpleMessage("이용 불가"),
    "securityNoSuccessfulSync": MessageLookupByLibrary.simpleMessage(
      "아직 동기화가 완료되지 않았습니다.",
    ),
    "securityPendingBackup": MessageLookupByLibrary.simpleMessage("백업 필요"),
    "securitySettings": MessageLookupByLibrary.simpleMessage("보안 설정"),
    "securityStatsNotConfigured": MessageLookupByLibrary.simpleMessage(
      "아직 클라우드 백업 플랫폼을 선택하지 않았습니다.",
    ),
    "securitySyncedData": MessageLookupByLibrary.simpleMessage("클라우드 데이터"),
    "select": MessageLookupByLibrary.simpleMessage("선택"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("음성 선택"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("피드백 보내기"),
    "setPassphrase": MessageLookupByLibrary.simpleMessage("암호 설정"),
    "setTodoReminder": MessageLookupByLibrary.simpleMessage("할 일 알림 설정"),
    "settings": MessageLookupByLibrary.simpleMessage("설정"),
    "setupYourAccount": MessageLookupByLibrary.simpleMessage("계정 설정"),
    "shareWithFriends": MessageLookupByLibrary.simpleMessage("친구와 공유하기"),
    "signIn": MessageLookupByLibrary.simpleMessage("로그인"),
    "signInWithEmail": MessageLookupByLibrary.simpleMessage("이메일로 로그인"),
    "signUp": MessageLookupByLibrary.simpleMessage("회원가입"),
    "signedInAs": MessageLookupByLibrary.simpleMessage("다음 계정으로 로그인됨:"),
    "sortByAtoZ": MessageLookupByLibrary.simpleMessage("가나다순 정렬"),
    "sortByLatestFirst": MessageLookupByLibrary.simpleMessage("최신순 정렬"),
    "sortByOldestFirst": MessageLookupByLibrary.simpleMessage("오래된 순 정렬"),
    "stay": MessageLookupByLibrary.simpleMessage("머무르기"),
    "submit": MessageLookupByLibrary.simpleMessage("제출"),
    "syncNow": MessageLookupByLibrary.simpleMessage("지금 동기화"),
    "syncSourceNone": MessageLookupByLibrary.simpleMessage("없음"),
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage("태그가 이미 존재합니다"),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage("여기를 눌러 제목 펼치기"),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "테마, 글꼴 및 언어 설정",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("테마 이름"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("고유 주제"),
    "to": MessageLookupByLibrary.simpleMessage("종료일"),
    "todoReminderNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "할 일 알림",
    ),
    "todoRemindersNeedUncheckedTodo": MessageLookupByLibrary.simpleMessage(
      "미리 알림을 설정하려면 할 일 항목에 커서를 놓습니다.",
    ),
    "todoRemindersUnavailableInEncryptedNotes":
        MessageLookupByLibrary.simpleMessage("미리 알림은 암호화된 메모에서 사용할 수 없습니다"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "너무 많은 잘못된 시도, 비밀번호로 로그인 해주세요",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage("툴바 위치"),
    "toolbarPositionBottom": MessageLookupByLibrary.simpleMessage("하단"),
    "toolbarPositionTop": MessageLookupByLibrary.simpleMessage("상단"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "예기치 않은 오류 발생",
    ),
    "unlockAction": MessageLookupByLibrary.simpleMessage("잠금해제"),
    "unlockButton": MessageLookupByLibrary.simpleMessage("잠금해제"),
    "unlockEncryptedNotes": MessageLookupByLibrary.simpleMessage(
      "암호화된 메모 잠금 해제",
    ),
    "unlockNoteAction": MessageLookupByLibrary.simpleMessage("메모 잠금 해제"),
    "unlockThisNote": MessageLookupByLibrary.simpleMessage("이 메모 잠금 해제"),
    "usePassphraseInstead": MessageLookupByLibrary.simpleMessage("대신 암호 사용"),
    "video": MessageLookupByLibrary.simpleMessage("비디오"),
    "visitWebsite": MessageLookupByLibrary.simpleMessage("당사 홈페이지 방문"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
    "whatsNew": MessageLookupByLibrary.simpleMessage("새로운 소식"),
    "whatsNewCloudBackupSubtitle": MessageLookupByLibrary.simpleMessage(
      "백업된 메모, 업로드 대기 중인 메모, 마지막 동기화 시점을 확인하세요.",
    ),
    "whatsNewCloudBackupTitle": MessageLookupByLibrary.simpleMessage(
      "클라우드 백업 상태",
    ),
    "whatsNewEncryptionSubtitle": MessageLookupByLibrary.simpleMessage(
      "암호 기반 암호화 및 복구 옵션으로 민감한 메모를 보호하세요.",
    ),
    "whatsNewEncryptionTitle": MessageLookupByLibrary.simpleMessage("암호화 정보"),
    "whatsNewHomeSearchSubtitle": MessageLookupByLibrary.simpleMessage(
      "홈 페이지에서 메모를 찾고 읽는 동안 메모 내부를 검색하세요.",
    ),
    "whatsNewHomeSearchTitle": MessageLookupByLibrary.simpleMessage("어디든지 검색"),
    "whatsNewStreakTrackingSubtitle": MessageLookupByLibrary.simpleMessage(
      "현재 연속, 최장 연속, 총 단어 수 및 6개월 활동 히트맵을 추적합니다.",
    ),
    "whatsNewStreakTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "연속 기록 및 통계 작성",
    ),
    "whatsNewThemesSubtitle": MessageLookupByLibrary.simpleMessage(
      "자신만의 색상과 비주얼 스타일로 DiaryVault를 개인화하세요.",
    ),
    "whatsNewThemesTitle": MessageLookupByLibrary.simpleMessage(
      "테마 생성 및 사용자 정의",
    ),
    "whatsNewTodosSubtitle": MessageLookupByLibrary.simpleMessage(
      "메모에 체크리스트를 추가하고, 독립 실행형 할 일을 만들고, 미리 알림을 받습니다.",
    ),
    "whatsNewTodosTitle": MessageLookupByLibrary.simpleMessage(
      "미리 알림이 있는 할 일 목록",
    ),
    "writingActivity": MessageLookupByLibrary.simpleMessage("쓰기 활동"),
    "writingActivityEmpty": MessageLookupByLibrary.simpleMessage(
      "여기에 글쓰기 날짜가 표시됩니다.",
    ),
    "writingActivityLess": MessageLookupByLibrary.simpleMessage("덜 보기"),
    "writingActivityMore": MessageLookupByLibrary.simpleMessage("더 보기"),
    "writingActivityPeriod": MessageLookupByLibrary.simpleMessage("지난 6개월"),
    "writingActivityPrivacyNote": MessageLookupByLibrary.simpleMessage(
      "암호화된 메모는 이 통계에 포함되지 않습니다.",
    ),
    "writingCurrentStreak": MessageLookupByLibrary.simpleMessage(
      "NAME OF TRANSLATORS",
    ),
    "writingDay": MessageLookupByLibrary.simpleMessage("일"),
    "writingDays": MessageLookupByLibrary.simpleMessage("일"),
    "writingLongestStreak": MessageLookupByLibrary.simpleMessage("최장 연속"),
    "writingTotalWords": MessageLookupByLibrary.simpleMessage("총 단어"),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("잘못된 PIN입니다"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "저장되지 않은 변경사항이 있습니다",
    ),
    "youWillBeNotifiedAt": m4,
    "yourRecoveryCodeTitle": MessageLookupByLibrary.simpleMessage("복구 코드"),
  };
}
