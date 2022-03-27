import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/core/network/network_info.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:dairy_app/features/auth/data/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_repository_test.mocks.dart';

@GenerateMocks([ILocalDataSource, IRemoteDataSource, NetworkInfo])
void main() {
  late MockNetworkInfo networkInfo;
  late MockIRemoteDataSource remoteDataSource;
  late MockILocalDataSource localDataSource;
  late AuthenticationRepository authenticationRepository;
  const String testEmail = "test@email.com";
  const String testPassword = "testpassword";
  const String testId = "77";
  final LoggedInUserModel user =
      LoggedInUserModel(email: testEmail, id: testId);

  setUp(() {
    networkInfo = MockNetworkInfo();
    localDataSource = MockILocalDataSource();
    remoteDataSource = MockIRemoteDataSource();
    authenticationRepository = AuthenticationRepository(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
        networkInfo: networkInfo);
  });

  group("Testing of signup with email and password method in auth repository",
      () {
    test(
      'should return SignUpFailure.noInternetConnection when there is no internet',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);

        // act
        var result = await authenticationRepository.signUpWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(SignUpFailure.noInternetConnection()));
      },
    );

    test(
      'should return SignUpFailure.emailAlreadyExists when Firebase throws FIrebaseAuthException with error code as email-already-in-use',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteDataSource.signUpUser(
                email: anyNamed("email"), password: anyNamed("password")))
            .thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

        // act
        var result = await authenticationRepository.signUpWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(SignUpFailure.emailAlreadyExists()));
      },
    );

    test(
      'should return SignUpFailure.invalidEmail when Firebase throws FIrebaseAuthException with error code as invalid-email',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteDataSource.signUpUser(
                email: anyNamed("email"), password: anyNamed("password")))
            .thenThrow(FirebaseAuthException(code: 'invalid-email'));

        // act
        var result = await authenticationRepository.signUpWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(networkInfo.isConnected);
        expect(result, Left(SignUpFailure.invalidEmail()));
      },
    );

    test(
      'should return SignUpFailure.invalidPassword when Firebase throws FIrebaseAuthException with error code as weak-password',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteDataSource.signUpUser(
                email: anyNamed("email"), password: anyNamed("password")))
            .thenThrow(FirebaseAuthException(code: 'weak-password'));

        // act
        var result = await authenticationRepository.signUpWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(networkInfo.isConnected);
        expect(
          result,
          Left(
            SignUpFailure.invalidPassword(
                "password must be atleast 6 characters"),
          ),
        );
      },
    );

    test(
      'should return SignUpFailure.unknownError when local database throws DatabaseInsertionException',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(
          remoteDataSource.signUpUser(
            email: anyNamed("email"),
            password: anyNamed("password"),
          ),
        ).thenAnswer((_) async => user);
        when(
          localDataSource.signUpUser(
              id: anyNamed("id"),
              email: anyNamed("email"),
              password: anyNamed("password")),
        ).thenThrow(const DatabaseInsertionException());

        // act
        var result = await authenticationRepository.signUpWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(networkInfo.isConnected);
        verify(
          localDataSource.signUpUser(
              id: anyNamed("id"),
              email: anyNamed("email"),
              password: anyNamed("password")),
        );
        verify(
          remoteDataSource.signUpUser(
            email: anyNamed("email"),
            password: anyNamed("password"),
          ),
        );
        expect(result, Left(SignUpFailure.unknownError()));
      },
    );
  });
}
