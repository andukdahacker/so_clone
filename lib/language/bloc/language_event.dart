import 'package:equatable/equatable.dart';

class LanguageEvent extends Equatable {
  const LanguageEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

enum Language { VI, EN }

class LanguageChanged extends LanguageEvent {
  const LanguageChanged({required this.language});
  final Language language;

  @override
  List<Object?> get props => [language];
}
