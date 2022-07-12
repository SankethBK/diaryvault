import 'package:dairy_app/app/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/view/app.dart';
import 'core/dependency_injection/injection_container.dart' as di;

Future<void> main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  return BlocOverrides.runZoned(
    () async {
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      );
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await di.init();
      runApp(const App());
    },
    blocObserver: AppBlocObserver(),
  );
}
