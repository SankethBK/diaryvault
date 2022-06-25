import 'dart:async';
import 'dart:convert';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';

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

      return userConfig.isFingerPrintAuthPossible == true &&
          userConfig.isFingerPrintLoginEnabled == true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  void startFingerPrintAuthIfNeeded() {
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
              showToast("fingerprint login failed");
            }, (user) {
              // for fingerprint login, it's never fresh login
              authSessionBloc.add(UserLoggedIn(user: user, freshLogin: false));

              // no need to update lastLoggedInUser as it was already present and we used sa,e
            });
          } else {
            log.e("lastLoginUser not found");
            showToast("fingerprint login failed");
          }
        } else if (value == FingerPrintAuthState.platformError) {
          fingerPrintAuthStreamSubscription?.cancel();
          isFingerPrintAuthActivated = false;
        } else if (value == FingerPrintAuthState.attemptsExceeded) {
          fingerPrintAuthStreamSubscription?.cancel();
          isFingerPrintAuthActivated = false;

          showToast("Too many wrong attempts, please login with password");
        } else if (value == FingerPrintAuthState.fail) {
          showToast("fingerprint not recognized");
        }
      });
    }
  }

  void cancel() {
    log.i("Cancelling fingerprint auth stream");
    fingerPrintAuthStreamSubscription?.cancel();
  }
}
