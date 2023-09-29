import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionNumberCubit extends Cubit<String> {
  VersionNumberCubit() : super('');

  void getVersion() async {
    final info = await PackageInfo.fromPlatform();
    emit(info.version);
  }
}
