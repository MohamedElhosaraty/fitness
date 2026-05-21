import 'package:fitness/core/helpers/user_preferences.dart';
import 'package:fitness/feature/onboarding/data/model/plan_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../feature/onboarding/data/model/workout_day_model.dart';
import '../../feature/onboarding/data/model/workout_exercise_model.dart';
import '../../feature/onboarding/data/model/workout_set_model.dart';
import '../networking/api_constants.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WorkoutSetModelAdapter());
    Hive.registerAdapter(WorkoutExerciseModelAdapter());
    Hive.registerAdapter(WorkoutDayModelAdapter());
    Hive.registerAdapter(PlanModelAdapter());
    await Hive.openBox<PlanModel>(Constants.planBox);
  }

  static Future<void> savePlan(PlanModel plan) async {
    final box = Hive.box<PlanModel>(Constants.planBox);
    await box.clear();
    await box.put(plan.planId, plan);
  }

  static PlanModel? getPlan(String planId) =>
      Hive.box<PlanModel>(Constants.planBox).get(planId);

  static WorkoutDayModel? getDay(String planId, int dayNumber) =>
      getPlan(planId)?.workoutDays.cast<WorkoutDayModel?>().firstWhere(
        (day) => day?.dayNumber == dayNumber,
        orElse: () => null,
      );

  static bool hasPlan(String planId) =>
      Hive.box<PlanModel>(Constants.planBox).containsKey(planId);

  static Future<void> clearPlans() async {
    await Hive.box<PlanModel>(Constants.planBox).clear();
  }

  static Future<void> resetWorkoutData() async {
    await clearPlans();
    UserPreferences.resetWorkoutProgress();
  }

  static Future<void> addSet({
    required String exerciseId,
    required WorkoutSetModel newSet,
  }) async {
    final plan = getPlan(UserPreferences.currentPlanId);
    if (plan == null) return;

    plan.workoutDays
        .firstWhere((d) => d.dayNumber == UserPreferences.completedDays)
        .workoutExercises
        .firstWhere((e) => e.exerciseId == exerciseId)
        .sets
        .add(newSet);

    await plan.save();
  }

  static Future<void> updateSet({
    required String exerciseId,
    required int setIndex,
    double? newWeight,
    int? newReps,
  }) async {
    final plan = getPlan(UserPreferences.currentPlanId);
    if (plan == null) return;

    final set =
        plan.workoutDays
            .firstWhere((d) => d.dayNumber == UserPreferences.completedDays)
            .workoutExercises
            .firstWhere((e) => e.exerciseId == exerciseId)
            .sets[setIndex];

    if (newWeight != null) set.weight = newWeight;
    if (newReps != null) set.reps = newReps;

    await plan.save();
  }
}
