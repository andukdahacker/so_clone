import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:so/authentication/repository/authentication_repository.dart';
import 'package:so/authentication/repository/models/models.dart';

import 'package:so/login/login.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockLoginResponse extends Mock implements LogInResponse {}

void main() {
  late AuthenticationRepository authenticationRepository;
  late LogInResponse logInResponse;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    logInResponse = MockLoginResponse();
  });

  group('LoginBloc', () {
    test('initial state is LoginState', () {
      final loginBloc = LoginBloc(
        authenticationRepository: authenticationRepository,
      );
      expect(loginBloc.state, const LoginState());
      loginBloc.close();
    });

    group('LoginSubmitted', () {
      blocTest<LoginBloc, LoginState>(
        'emits [submissionInProgress, submissionSuccess] when login succeeds',
        setUp: () {
          when(() => authenticationRepository.logIn(
                username: 'username',
                password: 'password',
              )).thenAnswer((_) async => logInResponse);
        },
        build: () => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) {
          bloc
            ..add(const LoginUsernameChanged('username'))
            ..add(const LoginPasswordChanged('password'))
            ..add(const LoginSubmitted());
        },
        expect: () => const <LoginState>[
          LoginState(
            username: Username.dirty('username'),
            status: FormzStatus.invalid,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.valid,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.submissionInProgress,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.submissionFailure,
          ),
        ],
        verify: (_) {
          verify(() => authenticationRepository.logIn(
              username: 'username', password: 'password')).called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits [LoginInProgress, LoginFailure] when logIn fails',
        setUp: () {
          when(
            () => authenticationRepository.logIn(
              username: 'username',
              password: 'password',
            ),
          ).thenThrow(Exception('oops'));
        },
        build: () => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) {
          bloc
            ..add(const LoginUsernameChanged('username'))
            ..add(const LoginPasswordChanged('password'))
            ..add(const LoginSubmitted());
        },
        expect: () => const <LoginState>[
          LoginState(
            username: Username.dirty('username'),
            status: FormzStatus.invalid,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.valid,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.submissionInProgress,
          ),
          LoginState(
            username: Username.dirty('username'),
            password: Password.dirty('password'),
            status: FormzStatus.submissionFailure,
          ),
        ],
        verify: (_) {
          verify(
            () => authenticationRepository.logIn(
                username: 'username', password: 'password'),
          ).called(1);
        },
      );
    });
  });
}
