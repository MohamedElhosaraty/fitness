import 'package:fitness/core/helpers/hive_helper.dart';
import 'package:fitness/feature/onboarding/data/model/workout_day_model.dart';

import '../helpers/app_boxes.dart';
import '../helpers/user_preferences.dart';

class HomeDayUtils {
  final WorkoutDayModel currentWorkoutDay;
  final List<int?> activeSlots;
  final int? currentSlot;

  HomeDayUtils({
    required this.currentWorkoutDay,
    required this.activeSlots,
    required this.currentSlot,
  });

  static Future<HomeDayUtils> get() async {
    final plan = HiveHelper.getPlan(UserPreferences.currentPlanId)!;

    final now = DateTime.now();
    final daysSinceSat = (now.weekday - DateTime.saturday + 7) % 7;
    final saturdayDate = now.subtract(Duration(days: daysSinceSat));
    final weekAnchor =
        DateTime(
          saturdayDate.year,
          saturdayDate.month,
          saturdayDate.day,
        ).toIso8601String();

    if (AppBoxes.weekAnchor != weekAnchor) {
      await AppBoxes.resetWeeklyProgress(weekAnchor);
    }

    final total = plan.availabilityDays;

    final daysPlayed =
        (AppBoxes.weekAnchor != weekAnchor) ? 0 : AppBoxes.daysPlayed;

    final lastSlot =
        (AppBoxes.weekAnchor != weekAnchor) ? null : AppBoxes.lastDayPlayed;

    final currentIndex = daysPlayed.clamp(0, plan.workoutDays.length - 1);
    final currentWorkoutDay = plan.workoutDays[currentIndex];

    final slots = calculateActiveSlots(
      total,
      daysPlayed,
      lastSlot,
      daysSinceSat,
    );

    final currentSlot =
        lastSlot ?? (daysPlayed < slots.length ? slots[daysPlayed] : null);

    return HomeDayUtils(
      currentWorkoutDay: currentWorkoutDay,
      activeSlots: slots,
      currentSlot: currentSlot,
    );
  }

  static List<int?> calculateActiveSlots(
    int total,
    int daysPlayed,
    int? lastSlot,
    int daysSinceSaturday,
  ) {
    List<int?> slots = [];
    var currentSlot = daysSinceSaturday + 1;

    final int step = total <= 4 ? 2 : 1;

    if (daysSinceSaturday == 0) {
      for (int i = 0; i <= 6 && slots.length < total; i += step) {
        slots.add(i);
      }
      return slots;
    } else if (daysPlayed == 0 && lastSlot == null) {
      for (int i = currentSlot - 1; i <= 6 && slots.length < total; i += step) {
        slots.add(i);
      }
      return slots;
    }

    if (lastSlot != null && currentSlot - lastSlot == 1) {
      currentSlot = currentSlot + 1;
    }

    for (int i = currentSlot - 1; i <= 6 && slots.length < total; i += step) {
      slots.add(i);
    }

    var daysLeft = total - daysPlayed;

    if (daysLeft >= slots.length) {
      return slots;
    }
    return slots.take(daysLeft).toList();
  }
}
