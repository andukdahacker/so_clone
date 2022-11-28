import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:so/language/bloc/language_event.dart';
import 'package:so/language/bloc/language_state.dart';
import 'package:so/language/repository/language_repository.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository _languageRepository;
  LanguageBloc({required LanguageRepository languageRepository})
      : _languageRepository = languageRepository,
        super(const LanguageState()) {
    on<LanguageChanged>(_onLanguageChanged);
  }

  Future<void> _onLanguageChanged(
      LanguageChanged event, Emitter<LanguageState> emit) async {
    await _languageRepository.setLanguagePrefs(event.locale);
    emit(state.copyWith(event.locale));
  }
}
