import 'package:fitness/feature/onboarding/data/model/plan_model.dart';
import 'package:fitness/feature/onboarding/data/model/workout_exercise_model.dart';
import 'package:fitness/feature/onboarding/data/service/firestore_onboarding_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/firestore_workout_helper.dart';
import '../../helpers/firestore_workout_test_data.dart';

void main() {
  late MockFirestoreService       mockFirestoreService;
  late FirestoreOnboardingService firestoreOnboardingService;
  late FirestoreWorkoutHelper     helper;

  setUp(() {
    mockFirestoreService       = MockFirestoreService();
    firestoreOnboardingService = FirestoreOnboardingService(firestoreService: mockFirestoreService);
    helper                     = FirestoreWorkoutHelper(mockFirestoreService);
  });

  group('getPlanWithExercises – success scenarios', () {

    test('should return Right(PlanModel) with all days and exercises', () async {
      helper.stubPlanSuccess();
      helper.stubExercisesSuccess();

      final result = await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);

      expect(result.isRight(), isTrue);
      result.fold(
            (_) => fail('Expected Right but got Left'),
            (model) {
          expect(model, isA<PlanModel>());
          expect(model.planId,           'buildMuscle_2day');
          expect(model.goalId,           'buildMuscle');
          expect(model.availabilityDays, 2);
          expect(model.workoutDays.length, 2);
        },
      );
    });

    test('should map workout days correctly', () async {
      helper.stubPlanSuccess();
      helper.stubExercisesSuccess();

      final result = await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);
      final model  = result.getOrElse(() => throw Exception());

      expect(model.workoutDays[0].dayNumber,      1);
      expect(model.workoutDays[0].getTitle('en'), 'Chest');
      expect(model.workoutDays[0].getTitle('ar'), 'صدر');

      expect(model.workoutDays[1].dayNumber,      2);
      expect(model.workoutDays[1].getTitle('en'), 'Back');
      expect(model.workoutDays[1].getTitle('ar'), 'ظهر');
    });

    test('should map exercise details correctly', () async {
      helper.stubPlanSuccess();
      helper.stubExercisesSuccess();

      final result = await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);
      final model  = result.getOrElse(() => throw Exception());

      final ex1 = model.workoutDays[0].workoutExercises[0];
      expect(ex1.exerciseId,          'pushUps');
      expect(ex1.reps,                '10');
      expect(ex1.sets,                '4');
      expect(ex1.restSeconds,         90);
      expect(ex1.getTitle('en'),      'Push Ups');
      expect(ex1.getTitle('ar'),      'ضغط');
      expect(ex1.getFormCues('en'),   ['Keep back straight']);
      expect(ex1.videoUrl, 'https://storage.googleapis.com/fitflow-vids/pushups.mp4');

      final ex2 = model.workoutDays[0].workoutExercises[1];
      expect(ex2.exerciseId,     'barbellBenchPress');
      expect(ex2.getTitle('en'), 'Barbell Bench Press');
    });

    test('should call getData once for plan and once per unique exercise', () async {
      helper.stubPlanSuccess();
      helper.stubExercisesSuccess();

      await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);

      verify(() => mockFirestoreService.getData(
        path: 'plans', documentId: tPlanId,
      )).called(1);

      verify(() => mockFirestoreService.getData(
        path: 'exercises', documentId: 'pushUps',
      )).called(1);

      verify(() => mockFirestoreService.getData(
        path: 'exercises', documentId: 'barbellBenchPress',
      )).called(1);

      verify(() => mockFirestoreService.getData(
        path: 'exercises', documentId: 'barbellRow',
      )).called(1);
    });
  });

  group('getPlanWithExercises – failure scenarios', () {

    test('should return Left(ServerFailure) when plan fetch fails', () async {
      helper.stubPlanFailure(tServerFailure);

      final result = await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);

      expect(result.isLeft(), isTrue);
      result.fold(
            (failure) => expect(failure, tServerFailure),
            (_)       => fail('Expected Left but got Right'),
      );

      verifyNever(() => mockFirestoreService.getData(
        path      : 'exercises',
        documentId: any(named: 'documentId'),
      ));
    });

    test('should skip failed exercise and return rest of exercises', () async {
      helper.stubPlanSuccess();
      helper.stubExercise1Failure(tServerFailure);

      final result = await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);

      expect(result.isRight(), isTrue);
      final model = result.getOrElse(() => throw Exception());

      // pushUps failed → exerciseId موجود بس بدون تفاصيل (fromMerged مع empty map)
      final ex1 = model.workoutDays[0].workoutExercises[0];
      expect(ex1.exerciseId,     'pushUps');
      expect(ex1.getTitle('en'), ''); // مفيش تفاصيل

      // barbellBenchPress نجح
      final ex2 = model.workoutDays[0].workoutExercises[1];
      expect(ex2.exerciseId,     'barbellBenchPress');
      expect(ex2.getTitle('en'), 'Barbell Bench Press');
    });

    test('should return Right with exercises having empty details when all exercise fetches fail', () async {
      helper.stubPlanSuccess();
      helper.stubAllExercisesFailure(tServerFailure);

      final result = await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);

      expect(result.isRight(), isTrue);
      final model = result.getOrElse(() => throw Exception());

      // الـ exercises موجودة بس بدون تفاصيل
      expect(model.workoutDays[0].workoutExercises.length, 2);
      expect(model.workoutDays[0].workoutExercises[0].getTitle('en'), '');
    });
  });

  group('getPlanWithExercises – edge cases', () {

    test('should return Right with empty workoutDays when plan has no days', () async {
      helper.stubPlanSuccessWithCustomData(tPlanDataEmptyDays);

      final result = await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => throw Exception()).workoutDays, isEmpty);

      verifyNever(() => mockFirestoreService.getData(
        path      : 'exercises',
        documentId: any(named: 'documentId'),
      ));
    });

    test('should return Right with empty workoutExercises when day has no exercises', () async {
      helper.stubPlanSuccessWithCustomData(tPlanDataEmptyExercises);

      final result = await firestoreOnboardingService.getPlanWithExercises(planId: tPlanId);

      expect(result.isRight(), isTrue);
      final model = result.getOrElse(() => throw Exception());
      expect(model.workoutDays[0].workoutExercises, isEmpty);

      verifyNever(() => mockFirestoreService.getData(
        path      : 'exercises',
        documentId: any(named: 'documentId'),
      ));
    });
  });

  group('WorkoutExerciseModel', () {

    test('fromMerged should correctly parse all fields', () {
      expect(tWorkoutExercise1.exerciseId,     'pushUps');
      expect(tWorkoutExercise1.reps,           '10');
      expect(tWorkoutExercise1.sets,           '4');
      expect(tWorkoutExercise1.restSeconds,    90);
      expect(tWorkoutExercise1.getTitle('en'), 'Push Ups');
      expect(tWorkoutExercise1.getTitle('ar'), 'ضغط');
      expect(tWorkoutExercise1.getFormCues('en'), ['Keep back straight']);
    });

    test('fromMerged should use default values when fields are missing', () {
      final model = WorkoutExerciseModel.fromMerged(
        planExercise : {},
        exerciseData : {},
      );
      expect(model.exerciseId,  '');
      expect(model.reps,        '');
      expect(model.sets,        '');
      expect(model.restSeconds, 0);
      expect(model.getTitle('en'), '');
    });

    test('getTitle should return Arabic when lang is ar', () {
      expect(tWorkoutExercise1.getTitle('ar'), 'ضغط');
    });

    test('getTitle should return English for any non-ar lang', () {
      expect(tWorkoutExercise1.getTitle('en'), 'Push Ups');
      expect(tWorkoutExercise1.getTitle('fr'), 'Push Ups');
    });
  });
}