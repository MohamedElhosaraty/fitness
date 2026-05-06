import 'package:hive/hive.dart';
import 'exercise_model.dart';
part 'day_exercise_model.g.dart';

@HiveType(typeId: 1)
class DayExerciseModel extends HiveObject {
  @HiveField(0) final String categoryEn;
  @HiveField(1) final String categoryAr;
  @HiveField(2) final List<ExerciseModel> exerciseRefs;

  DayExerciseModel({
    required this.categoryEn,
    required this.categoryAr,
    required this.exerciseRefs,
  });

  factory DayExerciseModel.fromMap(
      Map<String, dynamic> map, List<ExerciseModel> exercises) {
    final category = Map<String, String>.from(map['category'] ?? {});
    return DayExerciseModel(
      categoryEn:   category['en'] ?? '',
      categoryAr:   category['ar'] ?? '',
      exerciseRefs: exercises,
    );
  }

  String getCategory(String langCode) =>
      langCode == 'ar' ? categoryAr : categoryEn;
}