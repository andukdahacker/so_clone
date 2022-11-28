// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:so/authentication/authentication.dart';
import 'package:so/authentication/repository/authentication_repository.dart';
import 'package:so/authentication/repository/models/models.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  const user = User(id: 1, fullname: 'fullname', avatar: 'avatar');
  late AuthenticationRepository authenticationRepository;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    when(() => authenticationRepository.status)
        .thenAnswer((_) => Stream.empty());
  });

  group('AuthenticationBloc', () {
    test('initial state is AuthenticationState.unknown', () {
      final authenticationBloc = AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      );
      expect(authenticationBloc.state, AuthenticationState.unknown());
      authenticationBloc.close();
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is unauthenticated',
      setUp: () {
        when(() => authenticationRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.unauthenticated),
        );
      },
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.unauthenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when status is authenticated',
      setUp: () {
        when(() => authenticationRepository.status).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.authenticated),
        );
        when(() => authenticationRepository.getUser())
            .thenAnswer((_) async => user);
      },
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(user),
      ],
      verify: (_) {
        verify(
          () => authenticationRepository.getUser(),
        ).called(1);
      },
    );
  });

  group('AuthenticationStatusChanged', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [authenticated] when status is authenticated',
      setUp: () {
        when(() => authenticationRepository.getUser())
            .thenAnswer((_) async => user);
      },
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(
        AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(user),
      ],
      verify: (_) {
        verify(
          () => authenticationRepository.getUser(),
        ).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is unauthenticated',
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.unauthenticated),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.unauthenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is authenticated but getUser fails',
      setUp: () {
        when(() => authenticationRepository.getUser())
            .thenThrow(Exception('oops'));
      },
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(
        AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.unauthenticated(),
      ],
      verify: (_) {
        verify(
          () => authenticationRepository.getUser(),
        ).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unauthenticated] when status is authenticated '
      'but getUser returns null',
      setUp: () {
        when(() => authenticationRepository.getUser())
            .thenAnswer((_) async => null);
      },
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(
        AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.unauthenticated(),
      ],
      verify: (_) {
        verify(
          () => authenticationRepository.getUser(),
        ).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [unknown] when status is unknown',
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(
        AuthenticationStatusChanged(AuthenticationStatus.unknown),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.unknown(),
      ],
    );
  });

  group('AuthenticationLogoutRequested', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'calls logOut on authenticationRepository '
      'when AuthenticationLogoutRequested is added',
      build: () => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      act: (bloc) => bloc.add(AuthenticationLogoutRequested()),
      verify: (_) {
        verify(() => authenticationRepository.logOut()).called(1);
      },
    );
  });
}
