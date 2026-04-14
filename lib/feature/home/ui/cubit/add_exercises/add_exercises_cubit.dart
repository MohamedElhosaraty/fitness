
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/day_schedule_model.dart';
import '../../../domain/repos/workout_repo.dart';

part 'add_exercises_state.dart';

class AddExercisesCubit extends Cubit<AddExercisesState> {
  AddExercisesCubit(this.repo) : super(AddExercisesInitial());

  final WorkoutRepo repo;
  Future<void> addExercises({required DayScheduleModel day}) async {
    emit(AddExercisesLoading());

    final result = await repo.addExercises(days: day);

    result.fold(
          (failure) => emit(AddExercisesError(failure.message)),
          (_) => emit(AddExercisesSuccess()),
    );
  }
}
