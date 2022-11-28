// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:so/login/login.dart';

void main() {
  late LoginState loginState;
  setUp(() {
    loginState = LoginState(
        status: FormzStatus.valid,
        username: Username.dirty(),
        password: Password.dirty(),
        message: "");
  });
  group("LoginState", () {
    test('support value comparison', () {
      expect(loginState, loginState);
    });

    test('copyWith method', () {
      final newState = loginState.copyWith(
          status: FormzStatus.invalid,
          username: Username.pure(),
          password: Password.pure(),
          message: "1234");

      expect(
          newState,
          LoginState(
              status: FormzStatus.invalid,
              username: Username.pure(),
              password: Password.pure(),
              message: "1234"));
    });
  });
}
