import 'package:bloc_test/bloc_test.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../auth_form/auth_form_test.mocks.dart';

void main() {
  late AuthSessionBloc authSessionBloc;
  const LoggedInUser user = LoggedInUser(email: "sank@email.com", id: "77");

  setUp(() {
    authSessionBloc =
        AuthSessionBloc(keyValueDataSource: MockKeyValueDataSource());
  });

  group("Testing AuthSessionBloc", () {
    test("Initial state should be unauthenticated", () {
      expect(authSessionBloc.state, equals(const Unauthenticated()));
    });

    blocTest<AuthSessionBloc, AuthSessionState>(
      'emits [Authenticated] when MyEvent is added.',
      build: () => authSessionBloc,
      act: (bloc) => (bloc).add(const UserLoggedIn(user: user)),
      expect: () => <AuthSessionState>[const Authenticated(user: user)],
    );

    blocTest<AuthSessionBloc, AuthSessionState>(
      'emits [Authenticated, Unauthenticated, Authenticated, Unauthenticated] when [UserLoggedIn, AppLostFocus, UserLoggedIn, UserLoggedOut] is added.',
      build: () => authSessionBloc,
      act: (bloc) {
        bloc.add(const UserLoggedIn(user: user));
        bloc.add(AppLostFocus());
        bloc.add(const UserLoggedIn(user: user));
        bloc.add(UserLoggedOut());
      },
      expect: () => <AuthSessionState>[
        const Authenticated(user: user),
        const Unauthenticated(),
        const Authenticated(user: user),
        const Unauthenticated(),
      ],
    );
  });
}
