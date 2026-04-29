import 'package:fitness/feature/home/ui/cubit/workout_cubit/workout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/user_preferences.dart';
import '../../../domain/repo/workout_repo.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutRepo _repo;

  WorkoutCubit(this._repo) : super(WorkoutInitial());

  Future<void> getDayExercises(String goal, int days ,int indexDay) async {
    emit(WorkoutLoading());
    final result = await _repo.getExercisesForDay(goal, days, indexDay);
    result.fold(
          (failure) => emit(WorkoutError(failure.message)),
          (day)     => emit(WorkoutSuccess( dayExercises: day, completedDays: UserPreferences.completedDays )),
    );
  }

  void completeDay() {
    final int nextDay = UserPreferences.completedDays >= UserPreferences.numberDays
        ? 1
        : UserPreferences.completedDays + 1;

    UserPreferences.setCompletedDays = nextDay;

    getDayExercises(
      UserPreferences.selectedGoal,
      UserPreferences.numberDays,
      nextDay,
    );
  }}