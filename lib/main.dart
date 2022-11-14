import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  var locale = prefs.getString('locale');
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
    locale: locale == null
        ? const Locale('en')
        : locale == "en"
            ? const Locale('en')
            : const Locale('vi'),
  ));
}
