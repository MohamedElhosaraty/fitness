import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/model/exercise_model.dart';
import '../../data/model/weekly_schedule_model.dart';

abstract class WorkoutRepo {
  Future<Either<Failure, List<ExerciseModel>>> getExercises(String workoutType);

  Future<Either<Failure, void>> addExercises({
    required DaySchedule days,
  });
}