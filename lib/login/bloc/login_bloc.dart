import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../authentication/repository/authentication_repository.dart';
import '../../authentication/repository/models/models.dart';
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
        LogInResponse? logInResponse = await _authenticationRepository.logIn(
            username: state.username.value,
            password: state.password.value,
            rememberMe: event.rememberMe);

        if (logInResponse != null) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (err) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  Future<void> _onTryAutoLogin(
      TryAutoLogin event, Emitter<LoginState> emit) async {
    var result = await _authenticationRepository.getUserInfoPrefs();

    if (result != null) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      LogInResponse? logInResponse = await _authenticationRepository.logIn(
          username: result['username']!,
          password: result['password']!,
          rememberMe: true);

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
