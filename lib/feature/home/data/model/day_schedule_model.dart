import 'package:fitness/feature/home/data/model/exercise_model.dart';

import '../../domain/entity/workout_category.dart';


class DayScheduleModel {
  final String dayName;
  final WorkoutCategory? category;
  final List<ExerciseModel> exercises;
  final bool isToday;

  const DayScheduleModel({
    required this.dayName,
    this.category,
    List<ExerciseModel>? exercises,
    this.isToday = false,
  }) : exercises = exercises ?? const [];

  DayScheduleModel copyWith({
    String? dayName,
    WorkoutCategory? category,
    List<ExerciseModel>? exercises,
    bool? isToday,
  }) {
    return DayScheduleModel(
      dayName: dayName ?? this.dayName,
      category: category ?? this.category,
      exercises: exercises ?? this.exercises,
      isToday: isToday ?? this.isToday,
    );
  }
}

