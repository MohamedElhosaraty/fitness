import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/firestore_service.dart';
import '../../../../core/networking/api_constants.dart';
import '../model/exercise_model.dart';
import '../model/weekly_schedule_model.dart';

class FirebaseWorkoutService {
  final FirestoreService _firestoreService;

  FirebaseWorkoutService(this._firestoreService);


  // -----------------------Get Exercises-----------------------
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

  // -----------------------Add Exercises-----------------------
  Future<Either<Failure, void>> addExercises({
    required DaySchedule days,
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


  // -----------------------Get Day Exercises-----------------------

  Stream<Either<Failure, DaySchedule>> watchDayExercises({
    required String dayName,
  }) {
    try {
      final uId = FirebaseAuth.instance.currentUser!.uid;

      return _firestoreService
          .watchDocument(
        path: '${Constants.users}/$uId/${Constants.schedule}',
        documentId: dayName,
      )
          .map((result) => result.fold(
            (failure) => Left(failure),
            (data) {
          if (data == null) return Right(DaySchedule(dayName: dayName));

          final List exercisesList = data['exercises'] ?? [];
          return Right(DaySchedule(
            dayName: dayName,
            category: data['category'] != null
                ? WorkoutCategory.values.firstWhere(
                  (e) => e.name == data['category'],
              orElse: () => WorkoutCategory.rest,
            )
                : null,
            exercises: exercisesList
                .map((e) => ExerciseModel.fromMap(
              Map<String, dynamic>.from(e),
            ))
                .toList(),
          ));
        },
      ));
    } catch (e) {
      return Stream.value(Left(ServerFailure(e.toString())));
    }
  }}