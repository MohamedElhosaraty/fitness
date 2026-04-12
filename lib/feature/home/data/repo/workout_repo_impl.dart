import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repos/workout_repo.dart';
import '../model/exercise_model.dart';
import '../model/weekly_schedule_model.dart';
import '../service/firebase_workout_service.dart';

class WorkoutRepoImpl implements WorkoutRepo {
  final FirebaseWorkoutService _service;

  WorkoutRepoImpl(this._service);

  @override
  Future<Either<Failure, List<ExerciseModel>>> getExercises(String workoutType) async {
    return await _service.getExercises(workoutType);
  }

  @override
  Future<Either<Failure, void>> addExercises({
    required DaySchedule  days,
  }) async {
    return await _service.addExercises(days: days);
  }

  @override
  Future<Either<Failure, DaySchedule>> getDayExercises({required String dayName}) async {
    return await  _service.getDayExercises(dayName: dayName);
  }
}