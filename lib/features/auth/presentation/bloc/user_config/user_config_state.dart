part of 'user_config_cubit.dart';

abstract class UserConfigState {
  final UserConfigModel? userConfigModel;

  const UserConfigState({required this.userConfigModel});
}

class UserConfigDataState extends UserConfigState {
  const UserConfigDataState({UserConfigModel? userConfigModel})
      : super(userConfigModel: userConfigModel);
}
