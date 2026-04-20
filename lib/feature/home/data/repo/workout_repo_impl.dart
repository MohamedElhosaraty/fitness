import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/remote_config_service.dart';
import '../../domain/repos/workout_repo.dart';
import '../model/exercise_model.dart';
import '../model/day_schedule_model.dart';
import '../service/firebase_workout_service.dart';

class WorkoutRepoImpl implements WorkoutRepo {
  final FirebaseWorkoutService _service;
  final RemoteConfigService _remoteConfigService;

  List<ExerciseModel>? _cachedExercises;
  String? _cachedWorkoutType;

  WorkoutRepoImpl(this._service, this._remoteConfigService);

  @override
  Future<Either<Failure, List<ExerciseModel>>> getExercises(
      String workoutType,
      ) async {
    final isUpdated = _remoteConfigService.exercisesUpdated;
    if (!isUpdated &&
        _cachedExercises != null &&
        _cachedWorkoutType == workoutType) {
      return Right(_cachedExercises!);
    }

    final result = await _service.getExercises(workoutType);

    result.fold(
          (failure) => null,
          (exercises) {
        _cachedExercises = exercises;
        _cachedWorkoutType = workoutType;
      },
    );

    return result;
  }


  @override
  Future<Either<Failure, void>> addExercises({
    required DayScheduleModel  days,
  }) async {
    return await _service.addExercises(days: days);
  }

  @override
  Future<Either<Failure, List<DayScheduleModel>>> getAllDaysExercises() async {
    return await _service.getAllDaysExercises();
  }
}