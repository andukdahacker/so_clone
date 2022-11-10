import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LanguageEvent extends Equatable {
  const LanguageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LanguageFirstLoaded extends LanguageEvent {
  const LanguageFirstLoaded();

  @override
  List<Object?> get props => [];
}

class LanguageChanged extends LanguageEvent {
  const LanguageChanged({required this.locale});
  final Locale locale;

  @override
  List<Object?> get props => [locale];
}
