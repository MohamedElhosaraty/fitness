import 'package:fitness/feature/home/ui/cubit/workout_cubit/workout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/hive_helper.dart';
import '../../../../../core/helpers/user_preferences.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutInitial());

  void loadCurrentDay() {
    final day = HiveHelper.getDay(UserPreferences.currentPlanId,UserPreferences.completedDays);

    if (day == null) {
      emit(WorkoutError('No workout found'));
      return;
    }

    emit(WorkoutSuccess(
      dayExercises: day,
      completedDays: UserPreferences.completedDays,
    ));
  }

  void completeDay() {
    final int nextDay = UserPreferences.completedDays >= UserPreferences.numberDays
        ? 1
        : UserPreferences.completedDays + 1;

    UserPreferences.setCompletedDays = nextDay;

    final day = HiveHelper.getDay(UserPreferences.currentPlanId,UserPreferences.completedDays);

    if (day == null) {
      emit(WorkoutError('No workout found'));
      return;
    }

    emit(WorkoutSuccess(
      dayExercises: day,
      completedDays: nextDay,
    ));
  }
}