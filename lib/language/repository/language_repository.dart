import 'package:flutter/material.dart';
import 'package:so/api/dio.dart';

class LanguageRepository {
  Future<void> setLanguagePrefs(Locale locale) async {
    await DioApi().setLanguagePrefs(locale);
  }

  Future<Locale?> getLanguagePrefs() async {
    return await DioApi().getLanguagePrefs();
  }
}
