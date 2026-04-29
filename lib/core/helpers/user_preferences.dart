import 'shared_pref_helper.dart';
import 'shared_prefs_keys.dart';

class UserPreferences {
  static String get selectedGoal =>
      SharedPrefHelper.getString(SharedPrefsKeys.selectedGoal);

  static int get numberDays =>
      SharedPrefHelper.getInt(SharedPrefsKeys.numberDays);

 static set setSelectedGoal(String value) =>
      SharedPrefHelper.setString(SharedPrefsKeys.selectedGoal, value);

  static set setNumberDays(int value) =>
      SharedPrefHelper.setInt(SharedPrefsKeys.numberDays, value);

  static int get completedDays =>
      SharedPrefHelper.getInt(SharedPrefsKeys.completedDays);


  static set setCompletedDays(int value) =>
      SharedPrefHelper.setInt(SharedPrefsKeys.completedDays ,value );


}