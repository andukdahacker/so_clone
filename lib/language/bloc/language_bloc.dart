import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so/language/bloc/language_event.dart';
import 'package:so/language/bloc/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<LanguageChanged>(_onLanguageChanged);
  }

  Future<void> _onLanguageChanged(
      LanguageChanged event, Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    if (event.locale == const Locale('vi')) {
      await prefs.setString('locale', 'vi');
    } else {
      await prefs.setString('locale', 'en');
    }
    emit(state.copyWith(event.locale));
  }
}
