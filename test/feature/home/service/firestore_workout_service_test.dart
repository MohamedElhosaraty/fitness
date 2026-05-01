import 'package:fitness/feature/home/data/model/day_exercise_model.dart';
import 'package:fitness/feature/home/data/model/exercise_model.dart';
import 'package:fitness/feature/home/data/service/firestore_workout_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/firestore_workout_helper.dart';
import '../helpers/firestore_workout_test_data.dart';

void main() {
  late MockFirestoreService      mockFirestoreService;
  late FirestoreWorkoutService   firestoreWorkoutService;
  late FirestoreWorkoutHelper helper;

  setUp(() {
    mockFirestoreService    = MockFirestoreService();
    firestoreWorkoutService = FirestoreWorkoutService(mockFirestoreService);
    helper              = FirestoreWorkoutHelper(mockFirestoreService);
  });

  group('getDayExercises – success scenarios', () {
    test(
      'should return Right(DayExerciseModel) when day and all exercises are fetched successfully',
          () async {
        helper.stubDaySuccess();
        helper.stubExercisesSuccess();

        final result = await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        expect(result.isRight(), isTrue);

        result.fold(
              (_) => fail('No Documents'),
              (model) {
            expect(model, isA<DayExerciseModel>());

            expect(model.exerciseRefs.length, 2);
            expect(model.exerciseRefs[0].id, tExercise1.id);
            expect(model.exerciseRefs[1].id, tExercise2.id);
            expect(model.getCategory('en'), 'Chest');
            expect(model.getCategory('ar'), 'صدر');
          },
        );
      },
    );

    test(
      'should call once getData with correct planId and dayId',
          () async {
        helper.stubDaySuccess();
        helper.stubExercisesSuccess();

        await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        verify(
              () => mockFirestoreService.getData(
            path      : 'workoutPlans/$tPlanId/schedule',
            documentId: tDayId,
          ),
        ).called(1);
      },
    );

    test(
      'should call getData for each exerciseRef exactly once',
          () async {
        helper.stubDaySuccess();
        helper.stubExercisesSuccess();

        await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        verify(
              () => mockFirestoreService.getData(
            path      : 'allExercises',
            documentId: 'push_up',
          ),
        ).called(1);

        verify(
              () => mockFirestoreService.getData(
            path      : 'allExercises',
            documentId: 'bench_press',
          ),
        ).called(1);
      },
    );

    test(
      'should map exercise data correctly to ExerciseModel fields',
          () async {
        helper.stubDaySuccess();
        helper.stubExercisesSuccess();

        final result = await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);
        final model  = result.getOrElse(() => throw Exception());

        final ex1 = model.exerciseRefs[0];
        expect(ex1.titleEn,    'Push Up');
        expect(ex1.titleAr,    'ضغط');
        expect(ex1.subtitleEn, 'Chest focus');
        expect(ex1.subtitleAr, 'تركيز صدر');
        expect(ex1.sets,       '3');
        expect(ex1.repsMin,    '10');
        expect(ex1.repsMax,    '15');
        expect(ex1.repsDisplay, '3 x 10-15');

        final ex2 = model.exerciseRefs[1];
        expect(ex2.titleEn,    'Bench Press');
        expect(ex2.sets,       '4');
        expect(ex2.repsDisplay, '4 x 8-12');
      },
    );
  });

  group('getDayExercises – failure scenarios', () {
    test(
      'should return Left(ServerFailure) when day document fetch fails',
          () async {
        helper.stubDayFailure(tServerFailure);

        final result = await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        expect(result.isLeft(), isTrue);
        result.fold(
              (failure) => expect(failure, tServerFailure),
              (_)       => fail('No Failure'),
        );

        verifyNever(
              () => mockFirestoreService.getData(
            path      : 'allExercises',
            documentId: any(named: 'documentId'),
          ),
        );
      },
    );

    test(
      'should skip failed exercises and return only the successful ones',
          () async {
        helper.stubDaySuccess();
        helper.stubExercise1Failure(tServerFailure);

        final result = await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        expect(result.isRight(), isTrue);
        final model = result.getOrElse(() => throw Exception());
        expect(model.exerciseRefs.length, 1);
        expect(model.exerciseRefs[0].id, 'bench_press');
      },
    );

    test(
      'should return Right with empty exerciseRefs when all exercise fetches fail',
          () async {
        helper.stubDaySuccess();
        helper.stubAllExercisesFailure(tServerFailure);

        final result = await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        expect(result.isRight(), isTrue);
        final model = result.getOrElse(() => throw Exception());
        expect(model.exerciseRefs, isEmpty);
      },
    );
  });

  group('getDayExercises ', () {
    test(
      'should handle empty exerciseRefs list without calling allExercises',
          () async {
        helper.stubDaySuccessWithCustomData(tDayDataEmptyRefs);

        final result = await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => throw Exception()).exerciseRefs, isEmpty);

        verifyNever(
              () => mockFirestoreService.getData(
            path      : 'allExercises',
            documentId: any(named: 'documentId'),
          ),
        );
      },
    );

    test(
      'should handle missing exerciseRefs key in day data',
          () async {
        helper.stubDaySuccessWithCustomData(tDayDataNoRefsKey);

        final result = await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => throw Exception()).exerciseRefs, isEmpty);
      },
    );

    test(
      'should handle missing category key in day data',
          () async {
        helper.stubDaySuccessWithCustomData(tDayDataNoCategoryKey);

        final result = await firestoreWorkoutService.getDayExercises(tGoal, tDays, tIndexDay);

        final model = result.getOrElse(() => throw Exception());
        expect(model.getCategory('en'), '');
        expect(model.getCategory('ar'), '');
      },
    );

    test(
      'should build correct planId and dayId for different parameter combinations',
          () async {
        helper.stubDaySuccessForCustomPlan(
          goal    : 'getStrong',
          days    : 3,
          indexDay: 2,
          data    : {'category': {'en': 'Back'}, 'exerciseRefs': <String>[]},
        );

        final result = await firestoreWorkoutService.getDayExercises('getStrong', 3, 2);

        expect(result.isRight(), isTrue);
        verify(
              () => mockFirestoreService.getData(
            path      : 'workoutPlans/getStrong3Days/schedule',
            documentId: 'day2',
          ),
        ).called(1);
      },
    );
  });

  group('ExerciseModel', () {
    test('fromMap should correctly parse all fields', () {
      final model = ExerciseModel.fromMap(tExerciseData1);
      expect(model.id,         'push_up');
      expect(model.titleEn,    'Push Up');
      expect(model.titleAr,    'ضغط');
      expect(model.subtitleEn, 'Chest focus');
      expect(model.subtitleAr, 'تركيز صدر');
      expect(model.sets,       '3');
      expect(model.repsMin,    '10');
      expect(model.repsMax,    '15');
    });

    test('fromMap should use default values when fields are missing', () {
      final model = ExerciseModel.fromMap({});
      expect(model.id,      '');
      expect(model.titleEn, '');
      expect(model.sets,    '0');
      expect(model.repsMin, '0');
      expect(model.repsMax, '0');
    });

    test('getTitle should return Arabic title when lang is "ar"', () {
      expect(tExercise1.getTitle('ar'), 'ضغط');
    });

    test('getTitle should return English title for any non-"ar" lang', () {
      expect(tExercise1.getTitle('en'), 'Push Up');
      expect(tExercise1.getTitle('fr'), 'Push Up');
    });

    test('getSubtitle should return Arabic subtitle when lang is "ar"', () {
      expect(tExercise1.getSubtitle('ar'), 'تركيز صدر');
    });

    test('repsDisplay should format as "sets x repsMin-repsMax"', () {
      expect(tExercise1.repsDisplay, '3 x 10-15');
    });
  });

  group('DayExerciseModel', () {
    test('fromMap should correctly assign category and exercises', () {
      final model = DayExerciseModel.fromMap(tDayData, [tExercise1, tExercise2]);
      expect(model.category,  {'en': 'Chest', 'ar': 'صدر'});
      expect(model.exerciseRefs.length, 2);
    });

    test('getCategory should return correct ', () {
      final model = DayExerciseModel.fromMap(tDayData, []);
      expect(model.getCategory('en'), 'Chest');
      expect(model.getCategory('ar'), 'صدر');
    });

    test('getCategory should fallback to English when requested lang is missing', () {
      final model = DayExerciseModel.fromMap({'category': {'en': 'Legs'}}, []);
      expect(model.getCategory('ar'), 'Legs');
    });

    test('getCategory should return empty string when category map is empty', () {
      final model = DayExerciseModel.fromMap({}, []);
      expect(model.getCategory('en'), '');
    });

    test('fromMap should assign empty list when no exercises passed', () {
      final model = DayExerciseModel.fromMap(tDayData, []);
      expect(model.exerciseRefs, isEmpty);
    });
  });
}