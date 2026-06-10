import '../../../../onboarding/data/model/workout_day_model.dart';


sealed class WorkoutState {}

final class WorkoutInitial extends WorkoutState {}

final class WorkoutSuccess extends WorkoutState {
  final WorkoutDayModel dayExercises;

  WorkoutSuccess({required this.dayExercises});
}

final class WorkoutError extends WorkoutState {
  final String message;

  WorkoutError(this.message);
}





