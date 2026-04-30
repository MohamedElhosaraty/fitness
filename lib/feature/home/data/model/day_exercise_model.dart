import 'exercise_model.dart';

class DayExerciseModel {
  final Map<String, String> category;
  final List<ExerciseModel> exerciseRefs;

  DayExerciseModel({
    required this.category,
    required this.exerciseRefs,
  });

  factory DayExerciseModel.fromMap(Map<String, dynamic> map, List<ExerciseModel> exercises) {
    return DayExerciseModel(
      category: Map<String, String>.from(map['category'] ?? {}),
      exerciseRefs: exercises,
    );
  }

  String getCategory(String langCode) {
    return category[langCode] ?? category['en'] ?? '';
  }
}