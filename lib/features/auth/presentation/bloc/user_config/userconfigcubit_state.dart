part of 'userconfigcubit_cubit.dart';

abstract class UserConfigcubitState {
  const UserConfigcubitState();
}

class UserConfigDataState extends UserConfigcubitState {
  final UserConfigModel? userConfigModel;

  const UserConfigDataState({this.userConfigModel}) : super();
}
