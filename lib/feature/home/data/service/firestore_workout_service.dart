import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/firestore_service.dart';
import '../model/day_exercise_model.dart';
import '../model/exercise_model.dart';

class FirestoreWorkoutService {
  final FirestoreService _service;

  FirestoreWorkoutService(this._service);

  Future<Either<Failure, DayExerciseModel>> getDayExercises(
      String goal,
      int days,
      int indexDay
      ) async {
    final planId = '$goal${days}Days';
    final dayId = 'day$indexDay';

    final dayResult = await _service.getData(
      path: 'workoutPlans/$planId/schedule',
      documentId: dayId,
    );

    return dayResult.fold(
          (failure) => Left(failure),
          (data) async {
        final refs = List<String>.from(data['exerciseRefs'] ?? []);

        final snapshots = await Future.wait(
          refs.map((ref) => _service.getData(
            path: 'allExercises',
            documentId: ref,
          )),
        );

        final exercises = snapshots
            .where((e) => e.isRight())
            .map((e) => e.getOrElse(() => {}))
            .map((exerciseData) => ExerciseModel.fromMap(exerciseData))
            .toList();

        return Right(DayExerciseModel.fromMap(data, exercises));
      },
    );
  }
}