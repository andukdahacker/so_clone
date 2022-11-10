import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState({this.locale = const Locale("en")});

  LanguageState copyWith(
    Locale locale,
  ) {
    return LanguageState(locale: locale);
  }

  @override
  List<Object?> get props => [locale];
}
