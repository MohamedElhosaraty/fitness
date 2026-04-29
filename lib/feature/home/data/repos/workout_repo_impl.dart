import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repo/workout_repo.dart';
import '../model/day_exercise_model.dart';
import '../service/firestore_workout_service.dart';

class WorkoutRepoImpl implements WorkoutRepo {
  final FirestoreWorkoutService _service;
  WorkoutRepoImpl(this._service);

  @override
  Future<Either<Failure, DayExerciseModel>> getExercisesForDay(
      String goal,
      int days,
      int indexDay
      ) {
    return _service.getDayExercises(goal, days, indexDay);
  }
}