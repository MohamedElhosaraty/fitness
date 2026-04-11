import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/firestore_service.dart';
import '../model/exercise_model.dart';

class FirebaseWorkoutService {
  final FirestoreService _firestoreService;

  FirebaseWorkoutService(this._firestoreService);

  Future<Either<Failure, List<ExerciseModel>>> getExercises(
      String workoutType) async {
    final result = await _firestoreService.getListData(
      path: 'exercises',
      documentId: workoutType,
      listField: 'exercises',
    );

    return result.fold(
          (failure) => Left(failure),
          (list) => Right(list.map((e) => ExerciseModel.fromMap(e)).toList()),
    );
  }
}