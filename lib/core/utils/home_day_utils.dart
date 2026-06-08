import '../../feature/onboarding/data/model/workout_day_model.dart';
import '../helpers/app_boxes.dart';
import '../helpers/hive_helper.dart';
import '../helpers/user_preferences.dart';
import 'slot_calculator_utility.dart';

enum HomeDayStatus { reset, active, finished }

class HomeDaySlotUtility {
  final WorkoutDayModel currentWorkoutDay;
  final List<int?> activeSlots;
  final int? currentSlot;
  final List<int> finishedSlots;

  HomeDaySlotUtility({
    required this.currentWorkoutDay,
    required this.activeSlots,
    required this.currentSlot,
    required this.finishedSlots,
  });

  static Future<HomeDaySlotUtility> get() async {
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
    final finished = AppBoxes.finishedSlots;
    final daysPlayed = finished.length;
    final lastSlot = finished.isEmpty ? null : finished.last;

    final currentIndex = daysPlayed.clamp(0, plan.workoutDays.length - 1);
    final currentWorkoutDay = plan.workoutDays[currentIndex];

    final storedR1 = AppBoxes.r1RestDay;
    final result = SlotCalculatorUtility.calculateActiveSlots(
      total,
      daysPlayed,
      lastSlot,
      daysSinceSat,
      storedR1,
    );

    final slots = result.slots;
    if (result.r1ToStore != null && result.r1ToStore != storedR1) {
      await AppBoxes.setR1RestDay(result.r1ToStore!);
    }

    final currentSlot =
        slots.contains(daysSinceSat)
            ? daysSinceSat
            : slots.isNotEmpty && slots.first! <= daysSinceSat
            ? daysSinceSat
            : null;

    return HomeDaySlotUtility(
      currentWorkoutDay: currentWorkoutDay,
      activeSlots: slots,
      currentSlot: currentSlot,
      finishedSlots: finished,
    );
  }
}
