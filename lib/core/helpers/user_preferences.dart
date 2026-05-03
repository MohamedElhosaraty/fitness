import 'package:flutter/material.dart';
import 'shared_pref_helper.dart';
import 'shared_prefs_keys.dart';

class UserPreferences {
  //  ValueNotifiers
  static final ValueNotifier<String> selectedGoalNotifier = ValueNotifier('getStrong');
  static final ValueNotifier<int> numberDaysNotifier = ValueNotifier(3);

  // Goal
  static String get selectedGoal =>
      SharedPrefHelper.getString(SharedPrefsKeys.selectedGoal);

  static set setSelectedGoal(String value) {
    SharedPrefHelper.setString(SharedPrefsKeys.selectedGoal, value);
    selectedGoalNotifier.value = value;
  }

  // Days
  static int get numberDays =>
      SharedPrefHelper.getInt(SharedPrefsKeys.numberDays);

  static set setNumberDays(int value) {
    SharedPrefHelper.setInt(SharedPrefsKeys.numberDays, value);
    numberDaysNotifier.value = value;
  }

  // Completed Days
  static int get completedDays =>
      SharedPrefHelper.getInt(SharedPrefsKeys.completedDays);

  static set setCompletedDays(int value) =>
      SharedPrefHelper.setInt(SharedPrefsKeys.completedDays, value);
}