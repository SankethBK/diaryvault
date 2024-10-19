part of 'user_config_cubit.dart';
class UserConfigState  extends Equatable{
  final UserConfigModel? userConfigModel;
  final Map<String, dynamic>? selectedVoice;

  const UserConfigState({required this.userConfigModel,this.selectedVoice});
  @override
  List<Object?> get props => [
    userConfigModel,
    selectedVoice,
  ];

  UserConfigState copyWith({required Map<String, dynamic> selectedVoice}) {
    return UserConfigState(
        userConfigModel: userConfigModel,
        selectedVoice: selectedVoice,);
  }
}

class UserConfigDataState extends UserConfigState {
  const UserConfigDataState({UserConfigModel? userConfigModel})
      : super(userConfigModel: userConfigModel);
}
