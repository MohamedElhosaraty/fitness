
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/remote_config_service.dart';
import '../../../data/model/exercise_model.dart';
import '../../../domain/repos/workout_repo.dart';

part 'get_exercises_state.dart';

class GetExercisesCubit extends Cubit<GetExercisesState> {
  GetExercisesCubit(this.repo, this.remoteConfigService) : super(GetExercisesInitial());

  final WorkoutRepo repo;
  final RemoteConfigService remoteConfigService;

  List<ExerciseModel>? _cachedExercises;
  String? _cachedWorkoutType;

  Future<void> getExercises(String workoutType, {List<ExerciseModel> selectedExercises = const []}) async {

    final isUpdated = remoteConfigService.exercisesUpdated;

    if (!isUpdated && _cachedExercises != null && _cachedWorkoutType == workoutType) {
      _emitSuccess(_cachedExercises!, selectedExercises);
      return;
    }

    emit(GetExercisesLoading());

    final result = await repo.getExercises(workoutType);

    result.fold(
          (failure) => emit(GetExercisesError(failure.message)),
          (exercises) {
        _cachedExercises = exercises;
        _cachedWorkoutType = workoutType;
        _emitSuccess(exercises, selectedExercises);
      },
    );
  }

  void _emitSuccess(List<ExerciseModel> exercises, List<ExerciseModel> selectedExercises) {
    final selectedNames = selectedExercises.map((e) => e.name).toSet();
    final updatedExercises = exercises.map((e) => ExerciseModel(
      name: e.name,
      muscle: e.muscle,
      isSelected: selectedNames.contains(e.name),
    )).toList();
    emit(GetExercisesSuccess(exercises: updatedExercises));
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
