part of 'save_workout_plan_cubit.dart';

sealed class SaveWorkoutPlanState {}

final class SaveWorkoutPlanInitial extends SaveWorkoutPlanState {}

final class SaveWorkoutPlanLoading extends SaveWorkoutPlanState {}

final class SaveWorkoutPlanSuccess extends SaveWorkoutPlanState {}

final class SaveWorkoutPlanFailure extends SaveWorkoutPlanState {
  final String message;

  SaveWorkoutPlanFailure(this.message);
}
