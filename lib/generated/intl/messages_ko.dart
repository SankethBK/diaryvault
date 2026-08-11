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

  static String m3(time) => "알림 시간: ${time}";

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
    "byContinuingYouAgree": MessageLookupByLibrary.simpleMessage(
      "계속 진행함으로써 다음에 동의합니다:",
    ),
    "camera": MessageLookupByLibrary.simpleMessage("카메라"),
    "cancel": MessageLookupByLibrary.simpleMessage("취소"),
    "changeBackgroundColor": MessageLookupByLibrary.simpleMessage("배경색 변경..."),
    "changeEmail": MessageLookupByLibrary.simpleMessage("이메일 변경"),
    "changeImage": MessageLookupByLibrary.simpleMessage("이미지 변경"),
    "changePassword": MessageLookupByLibrary.simpleMessage("비밀번호 변경"),
    "chooseBackgroundImage": MessageLookupByLibrary.simpleMessage("배경 이미지 선택"),
    "chooseTheSyncSource": MessageLookupByLibrary.simpleMessage("동기화 소스 선택"),
    "chooseTheme": MessageLookupByLibrary.simpleMessage("테마 선택"),
    "chooseTime": MessageLookupByLibrary.simpleMessage("시간 선택"),
    "closeTheApp": MessageLookupByLibrary.simpleMessage("앱을 종료하시겠습니까?"),
    "cloudBackup": MessageLookupByLibrary.simpleMessage("클라우드 백업"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage("새 비밀번호 확인"),
    "confirmNewPin": MessageLookupByLibrary.simpleMessage("새 PIN 확인"),
    "continueAsGues": MessageLookupByLibrary.simpleMessage("게스트로 계속하기"),
    "create": MessageLookupByLibrary.simpleMessage("생성"),
    "createYourTheme": MessageLookupByLibrary.simpleMessage("테마 만들기"),
    "customThemeIntro": MessageLookupByLibrary.simpleMessage(
      "마음에 드는 사진을 선택하거나 배경색을 선택하면 테마를 만들 수 있습니다.",
    ),
    "customThemes": MessageLookupByLibrary.simpleMessage("사용자 정의 테마"),
    "dailyReminders": MessageLookupByLibrary.simpleMessage("일일 알림"),
    "darkLabel": MessageLookupByLibrary.simpleMessage("다크"),
    "darkTheme": MessageLookupByLibrary.simpleMessage("어두운 테마"),
    "dateFilter": MessageLookupByLibrary.simpleMessage("날짜 필터"),
    "defaultThemeName": MessageLookupByLibrary.simpleMessage("고유 주제"),
    "delete": MessageLookupByLibrary.simpleMessage("삭제"),
    "deletionFailed": MessageLookupByLibrary.simpleMessage("삭제 실패"),
    "done": MessageLookupByLibrary.simpleMessage("완료"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("계정이 없으신가요?"),
    "dropbox": MessageLookupByLibrary.simpleMessage("Dropbox"),
    "editTheme": MessageLookupByLibrary.simpleMessage("테마 수정"),
    "emailUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "이메일이 성공적으로 업데이트되었습니다, 로그인 해주세요",
    ),
    "enableAutoSave": MessageLookupByLibrary.simpleMessage("자동 저장 활성화"),
    "enableDailyReminders": MessageLookupByLibrary.simpleMessage("일일 알림 활성화"),
    "enableFingerPrintLogin": MessageLookupByLibrary.simpleMessage(
      "지문 로그인 활성화",
    ),
    "enablePINLogin": MessageLookupByLibrary.simpleMessage("PIN 로그인 활성화"),
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
    "incorrectPassword": MessageLookupByLibrary.simpleMessage("잘못된 비밀번호"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("유효하지 않은 백업 파일"),
    "language": MessageLookupByLibrary.simpleMessage("Korean"),
    "lastSynced": MessageLookupByLibrary.simpleMessage("마지막 동기화: "),
    "leave": MessageLookupByLibrary.simpleMessage("나가기"),
    "lightLabel": MessageLookupByLibrary.simpleMessage("라이트"),
    "link": MessageLookupByLibrary.simpleMessage("링크"),
    "logIn": MessageLookupByLibrary.simpleMessage("로그인"),
    "logOut": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "logOut2": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "loginToEnableAutoSync": MessageLookupByLibrary.simpleMessage(
      "자동 동기화를 사용하려면 로그인하세요",
    ),
    "moreInfo": MessageLookupByLibrary.simpleMessage("자세히 보기"),
    "muted": MessageLookupByLibrary.simpleMessage("뮤트 중"),
    "newPassword": MessageLookupByLibrary.simpleMessage("새 비밀번호"),
    "nextCloud": MessageLookupByLibrary.simpleMessage("NextCloud"),
    "notAvailable": MessageLookupByLibrary.simpleMessage("사용 불가"),
    "noteSavedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "노트가 성공적으로 저장되었습니다",
    ),
    "noteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "노트가 성공적으로 업데이트되었습니다",
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
    "reminders": MessageLookupByLibrary.simpleMessage("알림"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("비밀번호 초기화"),
    "resetPin": MessageLookupByLibrary.simpleMessage("PIN 재설정"),
    "saveAndApplyTheme": MessageLookupByLibrary.simpleMessage("테마 저장 및 적용"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("변경 사항 저장"),
    "security": MessageLookupByLibrary.simpleMessage("보안"),
    "securitySettings": MessageLookupByLibrary.simpleMessage("보안 설정"),
    "select": MessageLookupByLibrary.simpleMessage("Select"),
    "selectVoice": MessageLookupByLibrary.simpleMessage("음성 선택"),
    "sendFeedback": MessageLookupByLibrary.simpleMessage("피드백 보내기"),
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
    "tagAlreadyExists": MessageLookupByLibrary.simpleMessage("태그가 이미 존재합니다"),
    "tapToExpandTitle": MessageLookupByLibrary.simpleMessage("여기를 눌러 제목 펼치기"),
    "themeFontsAndLanguage": MessageLookupByLibrary.simpleMessage(
      "테마, 글꼴 및 언어 설정",
    ),
    "themeName": MessageLookupByLibrary.simpleMessage("테마 이름"),
    "themeNameHint": MessageLookupByLibrary.simpleMessage("고유 주제"),
    "to": MessageLookupByLibrary.simpleMessage("종료일"),
    "tooManyWrongAttempts": MessageLookupByLibrary.simpleMessage(
      "너무 많은 잘못된 시도, 비밀번호로 로그인 해주세요",
    ),
    "toolbarPosition": MessageLookupByLibrary.simpleMessage("툴바 위치"),
    "unexpectedErrorOccured": MessageLookupByLibrary.simpleMessage(
      "예기치 않은 오류 발생",
    ),
    "video": MessageLookupByLibrary.simpleMessage("비디오"),
    "webdavURL": MessageLookupByLibrary.simpleMessage("WebDAV URL"),
    "wrongPIN": MessageLookupByLibrary.simpleMessage("잘못된 PIN입니다"),
    "youHaveUnsavedChanges": MessageLookupByLibrary.simpleMessage(
      "저장되지 않은 변경사항이 있습니다",
    ),
    "youWillBeNotifiedAt": m3,
  };
}
