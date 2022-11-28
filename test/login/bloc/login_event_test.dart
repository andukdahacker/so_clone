// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:so/login/login.dart';

void main() {
  group('LoginEvent', () {
    group('LoginUsernameChanged', () {
      test('support value comparison', () {
        expect(
            LoginUsernameChanged('username'), LoginUsernameChanged('username'));
      });
    });

    group('LoginPasswordChanged', () {
      test('support value comparison', () {
        expect(
            LoginPasswordChanged('password'), LoginPasswordChanged('password'));
      });
    });

    group('LoginSubmitted', () {
      test('support value comparison', () {
        expect(
            LoginSubmitted(rememberMe: true), LoginSubmitted(rememberMe: true));
      });
    });

    group("TryAutoLogin", () {
      test('support value comparison', () {
        expect(TryAutoLogin(), TryAutoLogin());
      });
    });
  });
}
