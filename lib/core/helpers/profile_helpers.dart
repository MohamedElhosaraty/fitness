import 'package:flutter/material.dart';

import 'shared_pref_helper.dart';
import 'shared_prefs_keys.dart';
import 'user_preferences.dart';
import '../localization/localization_methods.dart';
import '../../generated/app_strings.dart';

String profileUserName(BuildContext context) {
  final name = SharedPrefHelper.getString(SharedPrefsKeys.name).trim();
  if (name.isNotEmpty) return name;
  return tr(context, AppStrings.userName);
}

String profileGoalTitle(BuildContext context, String goalId) {
  switch (goalId) {
    case 'getStrong':
      return tr(context, AppStrings.goalGetStrong);
    case 'buildMuscle':
      return tr(context, AppStrings.goalBuildMuscle);
    case 'generalFitness':
      return tr(context, AppStrings.goalGeneralFitness);
    default:
      return goalId;
  }
}

String profileFrequencyLabel(BuildContext context) {
  final days = UserPreferences.numberDays;
  return tr(context, AppStrings.daysPerWeek).replaceAll('{n}', '$days');
}

String profileInitials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
}
