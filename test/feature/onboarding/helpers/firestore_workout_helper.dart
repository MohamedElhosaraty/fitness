import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/core/helpers/firestore_service.dart';
import 'package:mocktail/mocktail.dart';
import 'firestore_workout_test_data.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

class FirestoreWorkoutHelper {
  final MockFirestoreService mock;
  const FirestoreWorkoutHelper(this.mock);

  void stubPlanSuccess() {
    when(
          () => mock.getData(path: 'plans', documentId: tPlanId),
    ).thenAnswer((_) async => Right(tPlanData));
  }

  void stubPlanFailure(Failure failure) {
    when(
          () => mock.getData(path: 'plans', documentId: tPlanId),
    ).thenAnswer((_) async => Left(failure));
  }

  void stubPlanSuccessWithCustomData(Map<String, dynamic> data) {
    when(
          () => mock.getData(path: 'plans', documentId: tPlanId),
    ).thenAnswer((_) async => Right(data));
  }

  void stubExercisesSuccess() {
    when(
          () => mock.getData(path: 'exercises', documentId: 'pushUps'),
    ).thenAnswer((_) async => Right(tExerciseData1));

    when(
          () => mock.getData(path: 'exercises', documentId: 'barbellBenchPress'),
    ).thenAnswer((_) async => Right(tExerciseData2));

    when(
          () => mock.getData(path: 'exercises', documentId: 'barbellRow'),
    ).thenAnswer((_) async => Right(tExerciseData3));
  }

  void stubExercise1Failure(Failure failure) {
    when(
          () => mock.getData(path: 'exercises', documentId: 'pushUps'),
    ).thenAnswer((_) async => Left(failure));

    when(
          () => mock.getData(path: 'exercises', documentId: 'barbellBenchPress'),
    ).thenAnswer((_) async => Right(tExerciseData2));

    when(
          () => mock.getData(path: 'exercises', documentId: 'barbellRow'),
    ).thenAnswer((_) async => Right(tExerciseData3));
  }

  void stubAllExercisesFailure(Failure failure) {
    when(
          () => mock.getData(
        path      : 'exercises',
        documentId: any(named: 'documentId'),
      ),
    ).thenAnswer((_) async => Left(failure));
  }
}