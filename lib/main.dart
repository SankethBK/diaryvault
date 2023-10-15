import 'package:dairy_app/core/constants/exports.dart';

import 'core/dependency_injection/injection_container.dart' as di;

Future<void> main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await Firebase.initializeApp();
  await di.init();
  runApp(const App());
}
