// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:so/language/bloc/language_bloc.dart';
import 'package:so/language/bloc/language_event.dart';
import 'package:so/language/bloc/language_state.dart';
import 'package:so/language/repository/language_repository.dart';

class MockLanguageRepository extends Mock implements LanguageRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LanguageRepository languageRepository;

  setUp(() {
    languageRepository = MockLanguageRepository();
  });

  group("LanguageBloc", () {
    test("emits LanguageState(Locale('en') initially", () {
      final languageBloc = LanguageBloc(languageRepository: languageRepository);
      expect(languageBloc.state.locale, Locale('en'));
      languageBloc.close();
    });

    blocTest(
      'emits Locale(vi) on LanguageChanged(Locale(vi))',
      setUp: () {
        when(
          () => languageRepository.setLanguagePrefs(Locale('vi')),
        ).thenAnswer((invocation) async {});
      },
      build: () => LanguageBloc(languageRepository: languageRepository),
      act: (bloc) => bloc.add(LanguageChanged(locale: Locale('vi'))),
      expect: () => <LanguageState>[LanguageState(locale: Locale('vi'))],
      verify: (bloc) {
        verify(
          () => languageRepository.setLanguagePrefs(Locale('vi')),
        ).called(1);
      },
    );
  });
}
