import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/shared_pref_helper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(ChangeLanguageSuccess(language: const Locale('en', 'US'))) {
    _loadSavedLanguage();
  }

  Locale get currentLocale => (state as ChangeLanguageSuccess).language;

  void _loadSavedLanguage() {
    final isEnglish = SharedPrefHelper.getBool('isEnglish');
    emit(ChangeLanguageSuccess(
      language: isEnglish ? const Locale('en', 'US') : const Locale('ar', 'EG'),
    ));
  }

  void changeLanguage(bool value) {
    SharedPrefHelper.setBool('isEnglish', value);
    emit(ChangeLanguageSuccess(
      language: value ? const Locale('en', 'US') : const Locale('ar', 'EG'),
    ));
  }
}