import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<TryAutoLogin>(_onTryAutoLogin);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.username]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final prefs = await SharedPreferences.getInstance();
        LogInResponse? logInResponse = await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );

        if (logInResponse == null) {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        } else if (logInResponse.status == 0) {
          emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              message: logInResponse.message));
        } else {
          if (event.rememberMe) {
            await prefs.setString('username', state.username.value);
            await prefs.setString('password', state.password.value);
          }
          await prefs.setString('token', logInResponse.data['token']);
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        }
      } catch (err) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  Future<void> _onTryAutoLogin(
      TryAutoLogin event, Emitter<LoginState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    var username = prefs.getString('username');
    var password = prefs.getString('password');

    if (username != null && password != null) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      LogInResponse? logInResponse = await _authenticationRepository.logIn(
        username: username,
        password: password,
      );

      if (logInResponse != null) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            message: "Auto login failed"));
      }
    }
  }
}
