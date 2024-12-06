import 'package:dairy_app/app/routes/routes.dart';
import 'package:dairy_app/app/themes/coral_bubble_theme.dart';
import 'package:dairy_app/app/themes/cosmic_theme.dart';
import 'package:dairy_app/app/themes/dark_academia.dart';
import 'package:dairy_app/app/themes/lush_green_theme.dart';
import 'package:dairy_app/app/themes/monochrome_pink.dart';
import 'package:dairy_app/app/themes/plain_dark.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/pages/welcome_page.dart';
import 'package:dairy_app/features/auth/data/repositories/pin_auth_repository.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/font/font_cubit.dart';
import 'package:dairy_app/features/auth/presentation/bloc/locale/locale_cubit.dart';
import 'package:dairy_app/features/auth/presentation/bloc/theme/theme_cubit.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/features/auth/presentation/pages/pin_auth_page.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


final log = printer("App");


class App extends StatelessWidget {
 const App({Key? key}) : super(key: key);


 @override
 Widget build(BuildContext context) {
   return MultiBlocProvider(
     providers: [
       BlocProvider<AuthSessionBloc>(
         create: (context) => sl<AuthSessionBloc>(),
       ),
       BlocProvider<AuthFormBloc>(
         create: (context) => sl<AuthFormBloc>(),
       ),
       BlocProvider<NotesBloc>(
         create: (context) => sl<NotesBloc>(),
       ),
       BlocProvider<NotesFetchCubit>(
         create: (context) => sl<NotesFetchCubit>(),
       ),
       BlocProvider<SelectableListCubit>(
         create: (context) => sl<SelectableListCubit>(),
       ),
       BlocProvider<NoteSyncCubit>(
         create: (context) => sl<NoteSyncCubit>(),
       ),
       BlocProvider<UserConfigCubit>(
         create: (context) => sl<UserConfigCubit>(),
       ),
       BlocProvider<ThemeCubit>(
         create: (context) => sl<ThemeCubit>(),
       ),
       BlocProvider<LocaleCubit>(
         create: (context) => sl<LocaleCubit>(),
       ),
       BlocProvider<FontCubit>(
         create: (context) => sl<FontCubit>(),
       )
     ],
     child: const AppView(),
   );
 }
}


class AppView extends StatefulWidget {
 const AppView({
   Key? key,
 }) : super(key: key);


 @override
 State<AppView> createState() => _AppViewState();
}


class _AppViewState extends State<AppView> {
 final _navigatorKey = GlobalKey<NavigatorState>();
 bool _isInitialized = false;


 @override
 void didChangeDependencies() {
   super.didChangeDependencies();


   if (!_isInitialized) {
     // trigger the initialization of lastLoggedinUserId
     BlocProvider.of<AuthSessionBloc>(context)
         .add(InitalizeLastLoggedInUser());
     _isInitialized = true;
   }
 }


 NavigatorState get _navigator => _navigatorKey.currentState!;


 ThemeData getThemeData(Themes currentTheme, FontFamily fontFamily) {
   switch (currentTheme) {
     case Themes.coralBubbles:
       return CoralBubble.getTheme(fontFamily);
     case Themes.cosmic:
       return Cosmic.getTheme(fontFamily);
     case Themes.lushGreen:
       return LushGreen.getTheme(fontFamily);
     case Themes.plainDark:
       return PlainDark.getTheme(fontFamily);
     case Themes.darkAcademia:
       return DarkAcademia.getTheme(fontFamily);
     case Themes.monochromePink:
       return MonochromePink.getTheme(fontFamily);


     default:
       return CoralBubble.getTheme(fontFamily);
   }
 }


 @override
 Widget build(BuildContext context) {
   return Builder(
     builder: (context) {
       final themeState = context.watch<ThemeCubit>().state;
       final localeCubit = context.watch<LocaleCubit>().state;
       final fontCubit = context.watch<FontCubit>().state;


       return MaterialApp(
         navigatorKey: _navigatorKey,
         debugShowCheckedModeBanner: false,
         title: "My Dairy",
         locale: localeCubit.currentLocale,
         supportedLocales: S.delegate.supportedLocales,
         localizationsDelegates: const [
           S.delegate,
           GlobalMaterialLocalizations.delegate,
           GlobalCupertinoLocalizations.delegate,
           GlobalWidgetsLocalizations.delegate
         ],
         theme: getThemeData(themeState.theme, fontCubit.currentFontFamily),
         builder: (BuildContext context, child) {
           return BlocListener<AuthSessionBloc, AuthSessionState>(
             listener: (context, state) {
               log.d("Auth session state is $state");


               //! Currently we are not passing lastLoggedinUser anywhere, if you implement session
               //! Rememeber to pass lastloggedinuser id as parameter to AuthPage


               if (state is Unauthenticated) {
                 bool isPINLoginEnabled =
                     sl<PINAuthRepository>().isPINAuthEnabled();


                 if (isPINLoginEnabled == true) {
                   _navigator.pushAndRemoveUntil(
                       MaterialPageRoute(builder: (_) => const PINAuthPage()),
                       (route) => false);
                 } else {
                   _navigator.pushAndRemoveUntil(
                       MaterialPageRoute(builder: (_) => AuthPage()),
                       (route) => false);
                 }
               } else if (state is Authenticated) {
                 log.d("freshLogin = ${state.freshLogin}");


                 if (state.freshLogin == true) {
                   _navigator.pushAndRemoveUntil(
                       MaterialPageRoute(builder: (_) => const WelcomePage()), // Navigate to welcomepage (quote screen) before homepage
                       (route) => false);
                 } else {
                   _navigator.pop();
                 }
               }
             },
             child: child,
           );
         },
         onGenerateRoute: RouteGenerator.generateRoute,
       );
     },
   );
 }
}
