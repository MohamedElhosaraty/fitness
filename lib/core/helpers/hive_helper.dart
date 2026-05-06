import 'package:fitness/feature/onboarding/data/model/day_exercise_model.dart';
import 'package:fitness/feature/onboarding/data/model/exercise_model.dart';
import 'package:hive_flutter/adapters.dart';



class HiveHelper {
  static const String workoutBox = 'workoutBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExerciseModelAdapter());
    Hive.registerAdapter(DayExerciseModelAdapter());
    await Hive.openBox<DayExerciseModel>(workoutBox);
  }

  static Future<void> saveAllDays(Map<String, DayExerciseModel> days) async {
    final box = Hive.box<DayExerciseModel>(workoutBox);
    await box.clear();
    await box.putAll(days);
  }

  static DayExerciseModel? getDay(String dayId) =>
      Hive.box<DayExerciseModel>(workoutBox).get(dayId);

  static Map<String, DayExerciseModel> getAllDays() =>
      Map<String, DayExerciseModel>.from(
          Hive.box<DayExerciseModel>(workoutBox).toMap());
}