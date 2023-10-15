import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';
import 'package:dairy_app/features/sync/core/exports.dart';

final log = printer("FingerPrintAuthRepo");

class FingerPrintAuthRepository {
  final IKeyValueDataSource keyValueDataSource;
  final AuthSessionBloc authSessionBloc;
  final IAuthenticationRepository authenticationRepository;

  // class variables
  StreamSubscription<FingerPrintAuthState?>? fingerPrintAuthStreamSubscription;
  bool isFingerPrintAuthActivated = false;

  FingerPrintAuthRepository({
    required this.keyValueDataSource,
    required this.authSessionBloc,
    required this.authenticationRepository,
  });

  /// Checks if UI can use fingerprint auth, based on last logged in user's preferences (if available)
  bool shouldActivateFingerPrint() {
    try {
      log.i("Checking for activating fingerprints");
      // see if lastLoggedInUser is present
      String? lastLoggedInUser =
          keyValueDataSource.getValue(Global.lastLoggedInUser);

      log.d("lastLoggedInUser = $lastLoggedInUser");

      if (lastLoggedInUser == null) {
        return false;
      }

      // See if userConfig is present for last logged in user
      String? userConfigData = keyValueDataSource.getValue(lastLoggedInUser);

      log.d("userConfig = $userConfigData");

      if (userConfigData == null) {
        return false;
      }

      var userConfig = UserConfigModel.fromJson(jsonDecode(userConfigData));

      return userConfig.isFingerPrintLoginEnabled == true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  void startFingerPrintAuthIfNeeded(BuildContext context) {
    if (shouldActivateFingerPrint()) {
      if (isFingerPrintAuthActivated == true) {
        log.i("Finger print auth was previously running, disabling it");
        fingerPrintAuthStreamSubscription?.cancel();
      }

      isFingerPrintAuthActivated = true;
      Stream<FingerPrintAuthState> fingerPrintAuthStream =
          authenticationRepository.processFingerPrintAuth();

      fingerPrintAuthStreamSubscription =
          fingerPrintAuthStream.listen((value) async {
        log.d("FingerPrintAuthState stream value = $value");

        if (value == FingerPrintAuthState.success) {
          fingerPrintAuthStreamSubscription?.cancel();
          isFingerPrintAuthActivated = false;
          // Fingerprint auth successful, starting passwordless sign in

          String? lastLoggedInUser =
              keyValueDataSource.getValue(Global.lastLoggedInUser);
          if (lastLoggedInUser != null) {
            var result = await authenticationRepository.signInDirectly(
                userId: lastLoggedInUser);

            result.fold((e) {
              log.e(e);
              showToast(AppLocalizations.of(context).fingerprintLoginFailed);
            }, (user) {
              // for fingerprint login, it's never fresh login
              //! since a feature is removed, freshlogin is true to avoid breaking changes
              authSessionBloc.add(UserLoggedIn(user: user, freshLogin: true));

              // no need to update lastLoggedInUser as it was already present and we used sa,e
            });
          } else {
            log.e("lastLoginUser not found");
            showToast(AppLocalizations.of(context).fingerprintLoginFailed);
          }
        } else if (value == FingerPrintAuthState.platformError) {
          fingerPrintAuthStreamSubscription?.cancel();
          isFingerPrintAuthActivated = false;
        } else if (value == FingerPrintAuthState.attemptsExceeded) {
          fingerPrintAuthStreamSubscription?.cancel();
          isFingerPrintAuthActivated = false;

          showToast(AppLocalizations.of(context).tooManyWrongAttempts);
        } else if (value == FingerPrintAuthState.fail) {
          // showToast("fingerprint not recognized");
        }
      });
    }
  }

  void cancel() {
    log.i("Cancelling fingerprint auth stream");
    fingerPrintAuthStreamSubscription?.cancel();
  }
}
