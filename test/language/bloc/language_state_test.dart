// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:so/language/bloc/language_state.dart';

void main() {
  group('LanguageState', () {
    test('support value comparison', () {
      expect(LanguageState(), LanguageState());
    });

    test('copyWith method', () {
      final languageState = LanguageState();

      final newState = languageState.copyWith(Locale('vi'));
      expect(newState, LanguageState(locale: Locale('vi')));
    });
  });
}
