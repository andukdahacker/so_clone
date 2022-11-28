import 'package:flutter/material.dart';
import 'package:so/authentication/repository/authentication_repository.dart';
import 'package:so/language/repository/language_repository.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final LanguageRepository languageRepository = LanguageRepository();

  var locale = await languageRepository.getLanguagePrefs();
  runApp(App(
    authenticationRepository: authenticationRepository,
    languageRepository: languageRepository,
    locale: locale == null
        ? const Locale('en')
        : locale == const Locale('en')
            ? const Locale('en')
            : const Locale('vi'),
  ));
}
