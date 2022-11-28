import 'package:flutter/material.dart';
import 'package:so/authentication/repository/models/logInResponse.dart';
import 'package:so/dashboard/repository/models/dashboard.dart';

abstract class Api {
  Future<LogInResponse?> login(String username, String password,
      [bool? rememberMe]) async {
    return null;
  }

  Future<void> logout() async {}

  Future<Map<String, String>?> getUserInfoPrefs() async {
    return null;
  }

  Future<Dashboard?> getDashboard() async {
    return null;
  }

  Future<void> setLanguagePrefs(Locale locale) async {}

  Future<Locale?> getLanguagePrefs() async {
    return null;
  }
}
