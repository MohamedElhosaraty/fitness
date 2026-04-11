
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/exercise_model.dart';
import '../../../domain/repos/workout_repo.dart';

part 'get_exercises_state.dart';

class GetExercisesCubit extends Cubit<GetExercisesState> {
  GetExercisesCubit(this.repo) : super(GetExercisesInitial());

  final WorkoutRepo repo;

  Future<void> getExercises(String workoutType) async {
    emit(GetExercisesLoading());

    final result = await repo.getExercises(workoutType);

    result.fold(
          (failure) => emit(GetExercisesError(failure.message)),
          (exercises) => emit(GetExercisesSuccess(exercises: exercises)),
    );
  }

  Future<void> toggleExercise(ExerciseModel exercise) async {
    if (state is GetExercisesSuccess) {
      final exercises = (state as GetExercisesSuccess).exercises;

      final updated = exercises.map((e) {
        if (e.name == exercise.name) {
          return ExerciseModel(
            name: e.name,
            muscle: e.muscle,
            isSelected: !e.isSelected,
          );
        }
        return e;
      }).toList();

      emit(GetExercisesSuccess(exercises: updated));
    }
  }}
