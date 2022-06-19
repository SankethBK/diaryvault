import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/data/repositories/user_config_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'userconfigcubit_state.dart';

class UserConfigcubitCubit extends Cubit<UserConfigcubitState> {
  final UserConfigRepository userConfigRepository;
  UserConfigcubitCubit({required this.userConfigRepository})
      : super(const UserConfigDataState());

  getUserConfig(String userId) async {
    UserConfigModel userConfig = await userConfigRepository.getValue(userId);
    emit(UserConfigDataState(userConfigModel: userConfig));
  }

  setUserConfig(String userId, String key, String value) async {
    UserConfigModel userConfig =
        await userConfigRepository.setValue(userId, key, value);
    emit(UserConfigDataState(userConfigModel: userConfig));
  }
}
