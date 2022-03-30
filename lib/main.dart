import 'package:dairy_app/app/bloc_observer.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/view/app.dart';
import 'core/dependency_injection/injection_container.dart' as di;

Future<void> main() async {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await di.init();
      runApp(App());
    },
    blocObserver: AppBlocObserver(),
  );
}
