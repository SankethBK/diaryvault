import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/data/repositories/user_config_repository.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';

part 'user_config_state.dart';

final log = printer("UserConfigCubit");

class UserConfigCubit extends Cubit<UserConfigState> {
  final UserConfigRepository userConfigRepository;
  final AuthSessionBloc authSessionBloc;
  late StreamSubscription authSessionBlocSubscription;
  String? userId;

  UserConfigCubit(
      {required this.userConfigRepository, required this.authSessionBloc})
      : super(const UserConfigDataState()) {
    authSessionBlocSubscription = authSessionBloc.stream.listen((state) {
      log.d("state received $state");
      if (state is Authenticated) {
        userId = state.user!.id;
        log.i("userId obtained = $userId");
      } else if (state is Unauthenticated) {
        log.i("user logged out");
        userId = null;
      }

      // to trigger the first user fetch, as it is null initially
      getUserConfig();
    });
  }

  getUserConfig() async {
    if (userId != null) {
      UserConfigModel userConfig = await userConfigRepository.getValue(userId!);
      emit(UserConfigDataState(userConfigModel: userConfig));
    } else {
      log.i("userId is null");
    }
  }

  setUserConfig(String key, dynamic value) async {
    if (userId != null) {
      UserConfigModel userConfig =
          await userConfigRepository.setValue(userId!, key, value);
      emit(UserConfigDataState(userConfigModel: userConfig));
    } else {
      log.i("userId is null");
    }
  }

  @override
  void onChange(Change<UserConfigState> change) {
    super.onChange(change);
    log.i(change);
  }
}
