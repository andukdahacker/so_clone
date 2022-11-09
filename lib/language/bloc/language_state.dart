import 'package:equatable/equatable.dart';
import 'package:so/language/bloc/language_event.dart';

class LanguageState extends Equatable {
  const LanguageState({this.language = Language.EN});

  const LanguageState.VI() : this(language: Language.VI);
  const LanguageState.EN() : this(language: Language.EN);
  final Language language;
  @override
  List<Object?> get props => [];
}
