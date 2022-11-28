// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:so/language/bloc/language_event.dart';

void main() {
  group('LanguageEvent', () {
    group('LanguageChanged', () {
      test("support value comparison", () {
        expect(LanguageChanged(locale: Locale('en')),
            LanguageChanged(locale: Locale('en')));
      });
    });
  });
}
