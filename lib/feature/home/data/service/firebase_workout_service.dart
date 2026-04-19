import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/firestore_service.dart';
import '../../../../core/networking/api_constants.dart';
import '../../domain/entity/workout_category.dart';
import '../model/exercise_model.dart';
import '../model/day_schedule_model.dart';

class FirebaseWorkoutService {
  final FirestoreService _firestoreService;

  FirebaseWorkoutService(this._firestoreService);

  // -----------------------Get Exercises-----------------------
  Future<Either<Failure, List<ExerciseModel>>> getExercises(
    String workoutType,
  ) async {
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

  // -----------------------Add Exercises-----------------------
  Future<Either<Failure, void>> addExercises({
    required DayScheduleModel days,
  }) async {
    try {
      final uId = FirebaseAuth.instance.currentUser!.uid;

      return await _firestoreService.addData(
        path: '${Constants.users}/$uId/${Constants.schedule}',
        uid: days.dayName,
        data: {
          'category': days.category?.name,
          'exercises': days.exercises.map((e) => e.toMap()).toList(),
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // -----------------------Get All Day Exercises-----------------------

  Future<Either<Failure, List<DayScheduleModel>>> getAllDaysExercises() async {
    try {
      final uId = FirebaseAuth.instance.currentUser!.uid;

      final result = await _firestoreService.getCollection(
        path: '${Constants.users}/$uId/${Constants.schedule}',
      );

      return result.fold(
            (failure) => Left(failure),
            (docs) {
          final days = docs.map((data) {
            final dayName = data['id'] as String;

            return DayScheduleModel(
              dayName: dayName,
              category: data['category'] != null
                  ? WorkoutCategory.values.firstWhere(
                    (e) => e.name == data['category'],
                orElse: () => WorkoutCategory.rest,
              )
                  : WorkoutCategory.rest,
              exercises: (data['exercises'] as List? ?? [])
                  .map((e) => ExerciseModel.fromMap(Map<String, dynamic>.from(e)))
                  .toList(),
            );
          }).toList();

          return Right(days);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
