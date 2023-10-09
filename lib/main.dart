import 'package:dairy_app/app/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/view/app.dart';
import 'core/dependency_injection/injection_container.dart' as di;

Future<void> main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await di.init();
  runApp(const App());
}
