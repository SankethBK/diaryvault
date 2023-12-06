import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// Importing the main app view
import 'app/view/app.dart';

// Importing dependency injection with an alias for better readability
import 'core/dependency_injection/injection_container.dart' as di;

// Main function to initialize the application
Future<void> main() async {
  // Configuration for Google Fonts
  GoogleFonts.config.allowRuntimeFetching = false;

  // Configuration for the global Bloc observer
  Bloc.observer = AppBlocObserver();

  // Initialization of Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Configuration for screen orientation
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  // Initialization of Firebase with error handling
  try {
    // Initializing Firebase
    await Firebase.initializeApp();
  } catch (e) {
    // Print an error message if Firebase initialization fails
    print('Error initializing Firebase: $e');
  }

  // Initialization of dependency injection
  await di.init();

  // Run the application by creating an instance of the App widget
  runApp(const App());
}
