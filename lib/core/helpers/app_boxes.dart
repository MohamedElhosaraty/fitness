import 'package:fitness/core/helpers/shared_pref_helper.dart';
import 'shared_prefs_keys.dart';

class AppBoxes {
  static String get weekAnchor =>
      SharedPrefHelper.getString(SharedPrefsKeys.weekAnchorKey);

  static int get daysPlayed =>
      SharedPrefHelper.getInt(SharedPrefsKeys.daysPlayedKey);

  static int? get lastDayPlayed {
    final val = SharedPrefHelper.getInt(SharedPrefsKeys.lastDayPlayedKey);
    return val == -1 ? null : val;
  }

  static Future<void> resetWeeklyProgress(String anchor) async {
    await SharedPrefHelper.setString(SharedPrefsKeys.weekAnchorKey, anchor);
    await SharedPrefHelper.setInt(SharedPrefsKeys.daysPlayedKey, 0);
    await SharedPrefHelper.setInt(SharedPrefsKeys.lastDayPlayedKey, -1);
  }
}