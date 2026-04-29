import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/model/day_exercise_model.dart';

abstract class WorkoutRepo {
  Future<Either<Failure, DayExerciseModel>> getExercisesForDay(
      String goal, int days,int indexDay
      );
}
