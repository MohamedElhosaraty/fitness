part of 'get_day_exercises_cubit.dart';

sealed class GetDayExercisesState {}

final class GetDayExercisesInitial extends GetDayExercisesState {}

final class GetDayExercisesLoading extends GetDayExercisesState {}

final class GetDayExercisesSuccess extends GetDayExercisesState {
  final DayScheduleModel day;
  GetDayExercisesSuccess({required this.day});
}

final class GetDayExercisesError extends GetDayExercisesState {
  final String message;
  GetDayExercisesError(this.message);
}
