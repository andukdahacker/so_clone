import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so/language/bloc/language_event.dart';
import 'package:so/language/bloc/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<LanguageChanged>(_onLanguageChanged);
  }

  void _onLanguageChanged(LanguageChanged event, Emitter<LanguageState> emit) {
    switch (event.language) {
      case Language.VI:
        return emit(const LanguageState.VI());
      case Language.EN:
        return emit(const LanguageState.EN());
    }
  }
}
