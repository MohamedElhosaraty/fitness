import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/core/helpers/firestore_service.dart';
import 'package:mocktail/mocktail.dart';

import 'firestore_workout_test_data.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

class FirestoreWorkoutHelper {
  final MockFirestoreService mock;

  const FirestoreWorkoutHelper(this.mock);


  void stubDaySuccess() {
    when(
          () => mock.getData(
        path      : 'workoutPlans/$tPlanId/schedule',
        documentId: tDayId,
      ),
    ).thenAnswer((_) async => Right(tDayData));
  }

  void stubDayFailure(Failure failure) {
    when(
          () => mock.getData(
        path      : 'workoutPlans/$tPlanId/schedule',
        documentId: tDayId,
      ),
    ).thenAnswer((_) async => Left(failure));
  }

  void stubDaySuccessWithCustomData(Map<String, dynamic> data) {
    when(
          () => mock.getData(
        path      : 'workoutPlans/$tPlanId/schedule',
        documentId: tDayId,
      ),
    ).thenAnswer((_) async => Right(data));
  }

  void stubDaySuccessForCustomPlan({
    required String goal,
    required int days,
    required int indexDay,
    required Map<String, dynamic> data,
  }) {
    final planId = '$goal${days}Days';
    final dayId  = 'day$indexDay';

    when(
          () => mock.getData(
        path      : 'workoutPlans/$planId/schedule',
        documentId: dayId,
      ),
    ).thenAnswer((_) async => Right(data));
  }


  void stubExercisesSuccess() {
    when(
          () => mock.getData(
        path      : 'allExercises',
        documentId: 'push_up',
      ),
    ).thenAnswer((_) async => Right(tExerciseData1));

    when(
          () => mock.getData(
        path      : 'allExercises',
        documentId: 'bench_press',
      ),
    ).thenAnswer((_) async => Right(tExerciseData2));
  }

  void stubExercise1Failure(Failure failure) {
    when(
          () => mock.getData(
        path      : 'allExercises',
        documentId: 'push_up',
      ),
    ).thenAnswer((_) async => Left(failure));

    when(
          () => mock.getData(
        path      : 'allExercises',
        documentId: 'bench_press',
      ),
    ).thenAnswer((_) async => Right(tExerciseData2));
  }

  void stubAllExercisesFailure(Failure failure) {
    when(
          () => mock.getData(
        path      : 'allExercises',
        documentId: any(named: 'documentId'),
      ),
    ).thenAnswer((_) async => Left(failure));
  }
}