import 'package:fitness/core/helpers/shared_pref_helper.dart';
import 'package:fitness/core/helpers/shared_prefs_keys.dart';

class AppBoxes {

  static String? get weekAnchor {
    final val = SharedPrefHelper.getString(SharedPrefsKeys.weekAnchorKey);
    return val.isEmpty ? null : val;
  }

  static Future<void> setWeekAnchor(String anchor) =>
      SharedPrefHelper.put(SharedPrefsKeys.weekAnchorKey, anchor);

  static List<int> get finishedSlots =>
      SharedPrefHelper.getIntList(SharedPrefsKeys.finishedSlotsKey);

  static Future<void> setFinishedSlots(List<int> slots) =>
      SharedPrefHelper.setIntList(SharedPrefsKeys.finishedSlotsKey, slots);

  static int? get r1RestDay {
    final value = SharedPrefHelper.getInt(
      SharedPrefsKeys.r1RestDayKey,
      defaultValue: -1,
    );
    return value == -1 ? null : value;
  }

  static Future<void> setR1RestDay(int day) =>
      SharedPrefHelper.setInt(SharedPrefsKeys.r1RestDayKey, day);

  static Future<void> clearR1RestDay() =>
      SharedPrefHelper.delete(SharedPrefsKeys.r1RestDayKey);

  static Future<void> resetWeeklyProgress(String anchor) async {
    await setWeekAnchor(anchor);
    await setFinishedSlots(const <int>[]);
    await clearR1RestDay();
  }

}