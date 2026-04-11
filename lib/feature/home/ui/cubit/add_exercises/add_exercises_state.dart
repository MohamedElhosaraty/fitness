part of 'add_exercises_cubit.dart';

sealed class AddExercisesState {}

class AddExercisesInitial extends AddExercisesState {}

class AddExercisesLoading extends AddExercisesState {}

class AddExercisesSuccess extends AddExercisesState {}

class AddExercisesError extends AddExercisesState {
  final String message;
  AddExercisesError(this.message);
}