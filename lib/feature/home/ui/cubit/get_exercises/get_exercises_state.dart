part of 'get_exercises_cubit.dart';

abstract class GetExercisesState {}

class GetExercisesInitial extends GetExercisesState {}

class GetExercisesLoading extends GetExercisesState {}

class GetExercisesSuccess extends GetExercisesState {
  final List<ExerciseModel> exercises;

  GetExercisesSuccess({
    required this.exercises,
  });
}

class GetExercisesError extends GetExercisesState {
  final String message;
  GetExercisesError(this.message);
}