import 'package:fitness/feature/onboarding/data/model/plan_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../feature/onboarding/data/model/workout_day_model.dart';
import '../../feature/onboarding/data/model/workout_exercise_model.dart';
import '../networking/api_constants.dart';

class HiveHelper {

  static Future<void> init() async {
    await Hive.initFlutter();
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
      getPlan(planId)?.workoutDays
          .cast<WorkoutDayModel?>()
          .firstWhere(
            (day) => day?.dayNumber == dayNumber,
        orElse: () => null,
      );


  static bool hasPlan(String planId) =>
      Hive.box<PlanModel>(Constants.planBox).containsKey(planId);

  static Future<void> clearPlans() async =>
      await Hive.box<PlanModel>(Constants.planBox).clear();
}