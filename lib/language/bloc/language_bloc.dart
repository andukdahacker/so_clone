import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so/language/bloc/language_event.dart';
import 'package:so/language/bloc/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<LanguageChanged>(_onLanguageChanged);
    on<LanguageFirstLoaded>(_onLanguageFirstLoaded);
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

  Future<void> _onLanguageFirstLoaded(
      LanguageFirstLoaded event, Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    var locale = prefs.getString('locale');
    if (locale != null) {
      if (locale == "en") {
        emit(state.copyWith(const Locale('en')));
      } else {
        emit(state.copyWith(const Locale('vi')));
      }
    }
  }
}
