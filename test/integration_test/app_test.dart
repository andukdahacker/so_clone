// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:so/app.dart';
import 'package:so/authentication/repository/authentication_repository.dart';
import 'package:so/authentication/repository/models/logInResponse.dart';
import 'package:so/dashboard/view/view.dart';

import 'package:so/login/login.dart';
import 'package:so/main.dart' as app;

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockLoginResponse extends Mock implements LogInResponse {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end testing', () {
    group('Login Page', () {
      late AuthenticationRepository authenticationRepository;

      setUp(() {
        authenticationRepository = MockAuthenticationRepository();
        when(() => authenticationRepository.status)
            .thenAnswer((_) => Stream.empty());
      });
      testWidgets("Find login page", (WidgetTester tester) async {
        app.main();

        await tester.pumpAndSettle();
        when((() => authenticationRepository.status)).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.unauthenticated),
        );

        expect(find.byType(LoginForm), findsOneWidget);

        final usernameInput =
            find.byKey(ValueKey('loginForm_usernameInput_textField'));
        final passwordInput =
            find.byKey(ValueKey('loginForm_passwordInput_textField'));
        final loginButton = find.byType(ElevatedButton);
        final languageSwitcher = find.byKey(ValueKey("LanguageSwitch"));

        await tester.tap(languageSwitcher);
        await tester.pumpAndSettle();

        expect(find.byKey(ValueKey('Switch_value_is_true')), findsOneWidget);

        await tester.enterText(usernameInput, "gv003");
        await tester.pumpAndSettle();
        await tester.enterText(passwordInput, "123456@");
        await tester.pumpAndSettle();

        await tester.tap(loginButton);

        await tester.pumpAndSettle();
      });
    });
  });
}
