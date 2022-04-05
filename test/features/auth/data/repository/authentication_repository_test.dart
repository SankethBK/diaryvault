import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/core/network/network_info.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:dairy_app/features/auth/data/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_repository_test.mocks.dart';

@GenerateMocks([IAuthLocalDataSource, IAuthRemoteDataSource, INetworkInfo])
void main() {
  late MockINetworkInfo networkInfo;
  late MockIAuthRemoteDataSource remoteDataSource;
  late MockIAuthLocalDataSource localDataSource;
  late AuthenticationRepository authenticationRepository;
  const String testEmail = "test@email.com";
  const String testPassword = "testpassword";
  const String testId = "77";
  final LoggedInUserModel user =
      LoggedInUserModel(email: testEmail, id: testId);

  setUp(() {
    networkInfo = MockINetworkInfo();
    localDataSource = MockIAuthLocalDataSource();
    remoteDataSource = MockIAuthRemoteDataSource();
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

  group("Testing of signin with email and password method in auth repository",
      () {
    test(
      'should return SignInFailure.passwordDoesNotExists when local data source throws same failure',
      () async {
        // arrange
        when(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(SignInFailure.wrongPassword());

        // act
        var result = await authenticationRepository.signInWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        expect(result, Left(SignInFailure.wrongPassword()));
      },
    );

    test(
      'should return Suser when local login succeeds',
      () async {
        // arrange
        when(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenAnswer((_) async => user);

        // act
        var result = await authenticationRepository.signInWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        expect(result, Right(user));
      },
    );

    test(
      'should return SignInFailure.noInternetConnection when local database returns SignInFailure.emailDoesNotExists() and internet is off',
      () async {
        // arrange
        when(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(SignInFailure.emailDoesNotExists());

        when(networkInfo.isConnected).thenAnswer((_) async => false);

        when(remoteDataSource.signInUser(
                email: anyNamed("email"), password: anyNamed("password")))
            .thenAnswer((_) async => user);

        // act
        var result = await authenticationRepository.signInWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );
        verify(networkInfo.isConnected);

        verifyZeroInteractions(
          remoteDataSource,
        );

        expect(result, Left(SignInFailure.noInternetConnection()));
      },
    );

    test(
      'should return SignInFailure.invalidEmail() when remote error code is invalid-email',
      () async {
        // // arrange
        when(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(SignInFailure.emailDoesNotExists());

        when(networkInfo.isConnected).thenAnswer((_) async => true);

        when(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(FirebaseAuthException(code: 'invalid-email'));

        // act
        var result = await authenticationRepository.signInWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert

        verify(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        verify(networkInfo.isConnected);

        verify(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        expect(result, Left(SignInFailure.invalidEmail()));
      },
    );

    test(
      'should make a call to remote login when local database returns SignInFailure.emailDoesNotExists() and internet is on',
      () async {
        // arrange
        when(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(SignInFailure.emailDoesNotExists());

        when(networkInfo.isConnected).thenAnswer((_) async => true);

        when(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenAnswer((_) async => user);

        when(localDataSource.cacheUser(
          id: anyNamed("id"),
          email: anyNamed("email"),
          password: anyNamed("password"),
        )).thenAnswer((_) async {});

        // act
        var result = await authenticationRepository.signInWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert
        verify(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        verify(networkInfo.isConnected);

        verify(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        verify(localDataSource.cacheUser(
          id: anyNamed("id"),
          email: anyNamed("email"),
          password: anyNamed("password"),
        ));

        expect(result, Right(user));
      },
    );

    test(
      'should return SignInFailure.userDisabled() when remote error code is user-disabled',
      () async {
        // arrange
        when(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(SignInFailure.emailDoesNotExists());

        when(networkInfo.isConnected).thenAnswer((_) async => true);

        when(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(FirebaseAuthException(code: 'user-disabled'));

        // act
        var result = await authenticationRepository.signInWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert

        verify(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        verify(networkInfo.isConnected);

        verify(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        expect(result, Left(SignInFailure.userDisabled()));
      },
    );

    test(
      'should return SignInFailure.emailDoesNotExists() when remote error code is user-not-found',
      () async {
        // arrange
        when(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(SignInFailure.emailDoesNotExists());

        when(networkInfo.isConnected).thenAnswer((_) async => true);

        when(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

        // act
        var result = await authenticationRepository.signInWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert

        verify(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        verify(networkInfo.isConnected);

        verify(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        expect(result, Left(SignInFailure.emailDoesNotExists()));
      },
    );

    test(
      'should return SignInFailure.wrongPassword() when remote error code is wrong-password',
      () async {
        // arrange
        when(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(SignInFailure.emailDoesNotExists());

        when(networkInfo.isConnected).thenAnswer((_) async => true);

        when(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenThrow(FirebaseAuthException(code: 'wrong-password'));

        // act
        var result = await authenticationRepository.signInWithEmailAndPassword(
            email: testEmail, password: testPassword);

        // assert

        verify(
          localDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        verify(networkInfo.isConnected);

        verify(
          remoteDataSource.signInUser(
              email: anyNamed("email"), password: anyNamed("password")),
        );

        expect(result, Left(SignInFailure.wrongPassword()));
      },
    );
  });
}
