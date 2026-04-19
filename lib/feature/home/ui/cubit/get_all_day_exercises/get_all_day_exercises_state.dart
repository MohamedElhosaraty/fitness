part of 'get__all_day_exercises_cubit.dart';

sealed class GetAllDayExercisesState {}

final class GetAllDayExercisesInitial extends GetAllDayExercisesState {}

final class GetAllDayExercisesLoading extends GetAllDayExercisesState {}

final class GetAllDayExercisesSuccess extends GetAllDayExercisesState {
  final List<DayScheduleModel> listDays;
  GetAllDayExercisesSuccess({required this.listDays});
}

final class GetAllDayExercisesError extends GetAllDayExercisesState {
  final String message;
  GetAllDayExercisesError(this.message);
}
