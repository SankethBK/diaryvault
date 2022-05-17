import 'package:dairy_app/core/network/network_info.dart';
import 'package:dairy_app/features/auth/core/validators/email_validator.dart';
import 'package:dairy_app/features/auth/core/validators/password_validator.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source.dart';
import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';
import 'package:dairy_app/features/auth/data/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:dairy_app/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/notes/data/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //* --- core ---

  //* network
  final InternetConnectionChecker connectionChecker =
      InternetConnectionChecker();

  sl.registerSingleton<INetworkInfo>(NetworkInfo(connectionChecker));

  //* FEATURE: auth

  //* core
  sl.registerLazySingleton<EmailValidator>(() => EmailValidator());
  sl.registerLazySingleton<PasswordValidator>(() => PasswordValidator());

  //* Data sources
  sl.registerSingleton<IAuthLocalDataSource>(AuthLocalDataSource());
  sl.registerSingleton<IAuthRemoteDataSource>(AuthRemoteDataSource());

  //* Repository
  sl.registerSingleton<IAuthenticationRepository>(AuthenticationRepository(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));

  //* Blocs
  sl.registerSingleton<AuthSessionBloc>(AuthSessionBloc());
  sl.registerLazySingleton<AuthFormBloc>(
    () => AuthFormBloc(
      authSessionBloc: sl(),
      signUpWithEmailAndPassword: sl(),
      signInWithEmailAndPassword: sl(),
    ),
  );

  //* Usecases
  sl.registerLazySingleton<SignUpWithEmailAndPassword>(
    () => SignUpWithEmailAndPassword(
      emailValidator: sl(),
      passwordValidator: sl(),
      authenticationRepository: sl(),
    ),
  );

  sl.registerLazySingleton<SignInWithEmailAndPassword>(
    () => SignInWithEmailAndPassword(
      emailValidator: sl(),
      authenticationRepository: sl(),
    ),
  );

  //* FEATURE: notes

  //* Data sources
  sl.registerSingleton<INotesLocalDataSource>(NotesLocalDataSource());

  //* Repository
  sl.registerSingleton<INotesRepository>(
      NotesRepository(notesLocalDataSource: sl()));

  //* Blocs
  sl.registerLazySingleton(() => NotesBloc(notesRepository: sl()));
}
