import 'package:fitness/feature/onboarding/data/model/day_exercise_model.dart';
import 'package:fitness/feature/onboarding/data/model/exercise_model.dart';
import 'package:hive_flutter/adapters.dart';

import '../networking/api_constants.dart';



class HiveHelper {

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExerciseModelAdapter());
    Hive.registerAdapter(DayExerciseModelAdapter());
    await Hive.openBox<DayExerciseModel>(Constants.workoutBox);
  }

  static Future<void> saveAllDays(Map<String, DayExerciseModel> days) async {
    final box = Hive.box<DayExerciseModel>(Constants.workoutBox);
    await box.clear();
    await box.putAll(days);
  }

  static DayExerciseModel? getDay(String dayId) =>
      Hive.box<DayExerciseModel>(Constants.workoutBox).get(dayId);

  static Map<String, DayExerciseModel> getAllDays() =>
      Map<String, DayExerciseModel>.from(
          Hive.box<DayExerciseModel>(Constants.workoutBox).toMap());
}