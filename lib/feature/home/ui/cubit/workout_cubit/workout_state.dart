

import '../../../data/model/day_exercise_model.dart';

sealed class WorkoutState {}

final class WorkoutInitial extends WorkoutState {}

final class WorkoutLoading extends WorkoutState {}

final class WorkoutSuccess extends WorkoutState {
  final DayExerciseModel dayExercises;
  final int completedDays;

  WorkoutSuccess({required this.dayExercises, required this.completedDays});
}

final class WorkoutError extends WorkoutState {
  final String message;

  WorkoutError(this.message);
}





