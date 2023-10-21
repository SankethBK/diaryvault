import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/core/pages/settings_page.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    final log = printer("Router");

    log.i(" routing to ${settings.name} with args $args ");

    if (settings.name == HomePage.route) {
      return MaterialPageRoute(builder: (_) => const HomePage());
    } else if (settings.name == AuthPage.route) {
      return MaterialPageRoute(builder: (_) => AuthPage());
    } else if (settings.name == NoteCreatePage.routeThroughHome) {
      return MaterialPageRoute(builder: (_) => const NoteCreatePage());
    } else if (settings.name == NoteCreatePage.routeThroughNoteReadOnly) {
      return MaterialPageRoute(builder: (_) => const NoteCreatePage());
    } else if (settings.name == NotesReadOnlyPage.routeThroughHome) {
      return MaterialPageRoute(
          builder: (_) => NotesReadOnlyPage(id: settings.arguments as String));
    } else if (settings.name == NotesReadOnlyPage.routeThoughNotesCreate) {
      return MaterialPageRoute(
          builder: (_) => const NotesReadOnlyPage(id: null));
    } else if (settings.name == SettingsPage.route) {
      return MaterialPageRoute(builder: (_) => const SettingsPage());
    }

    return MaterialPageRoute(
      builder: (context) => Center(
        child: Text(AppLocalizations.of(context).pageNotFound),
      ),
    );
  }
}
