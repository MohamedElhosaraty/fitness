import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/core/helpers/firestore_service.dart';
import 'package:fitness/feature/onboarding/data/model/onboarding_goal_model.dart';
import 'package:fitness/feature/onboarding/data/service/firestore_onboarding_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  late FirestoreOnboardingService firestoreOnboardingService;
  late MockFirestoreService mockFirestoreService;
  late List<OnboardingGoalModel> tGoalModels;

  final tGoalMaps = <Map<String, dynamic>>[
    {
      'id': 'goal_001',
      'title': {'en': 'Build Muscle', 'ar': 'بناء العضلات'},
      'subtitle': {'en': 'Focus on hypertrophy and strength.', 'ar': 'التركيز على ضخامة العضلات.'},
      'icon': 'fitness_center',
    },
    {
      'id': 'goal_002',
      'title': {'en': 'Get Strong', 'ar': 'اكتساب القوة'},
      'subtitle': {'en': 'Prioritize heavy lifting and power.', 'ar': 'التركيز على الرفع الثقيل.'},
      'icon': 'fitness_center',
    },
    {
      'id': 'goal_003',
      'title': {'en': 'General Fitness', 'ar': 'لياقة عامة'},
      'subtitle': {'en': 'Balanced health and mobility.', 'ar': 'صحة متوازنة وحركة.'},
      'icon': 'directions_run',
    },
  ];

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    firestoreOnboardingService = FirestoreOnboardingService(
      firestoreService: mockFirestoreService,
    );
    tGoalModels = tGoalMaps
        .map((map) => OnboardingGoalModel.fromMap(map, map['id'] as String))
        .toList();
  });

  group('getOnboardingGoals', () {
    group('Success -', () {
      test('returns Right with List<OnboardingGoalModel> when call succeeds',
              () async {
            when(
                  () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
            ).thenAnswer((_) async => Right(tGoalMaps));

            final result = await firestoreOnboardingService.getOnboardingGoals();

            expect(result.isRight(), isTrue);
            result.fold(
                  (_) => fail('No Documents'),
                  (goals) {
                expect(goals, isA<List<OnboardingGoalModel>>());
                expect(goals.length, equals(3));
              },
            );
            verify(
              () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
            ).called(1);
          });

      test('maps Firestore documents correctly to OnboardingGoalModel objects',
              () async {
            when(
                  () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
            ).thenAnswer((_) async => Right(tGoalMaps));

            final result = await firestoreOnboardingService.getOnboardingGoals();

            result.fold(
                  (_) => fail('No Documents'),
                  (goals) {
                expect(goals.length, equals(tGoalModels.length));
                for (int i = 0; i < goals.length; i++) {
                  expect(goals[i].id, equals(tGoalModels[i].id));
                  expect(goals[i].title, equals(tGoalModels[i].title));
                  expect(goals[i].subtitle, equals(tGoalModels[i].subtitle));
                  expect(goals[i].icon, equals(tGoalModels[i].icon));
                }
              },
            );
          });

      test('returns empty list when collection has no documents', () async {
        when(
              () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
        ).thenAnswer((_) async => const Right([]));

        final result = await firestoreOnboardingService.getOnboardingGoals();

        result.fold(
              (_) => fail('No Documents'),
              (goals) => expect(goals, isEmpty),
        );
      });

      test('uses the "id" field from document as the model identifier',
              () async {
            when(
                  () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
            ).thenAnswer((_) async => const Right([
              {
                'id': 'goal_abc',
                'title': {'en': 'Get Strong'},
                'subtitle': {'en': 'Prioritize heavy lifting.'},
                'icon': 'fitness_center',
              }
            ]));

            final result = await firestoreOnboardingService.getOnboardingGoals();

            result.fold(
                  (_) => fail('No Documents'),
                  (goals) => expect(goals.single.id, equals('goal_abc')),
            );
          });

      test('falls back to empty string id when "id" key is absent', () async {
        when(
              () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
        ).thenAnswer((_) async => const Right([
          {
            'title': {'en': 'Get Strong'},
            'subtitle': {'en': 'Prioritize heavy lifting.'},
            'icon': 'fitness_center',
          }
        ]));

        final result = await firestoreOnboardingService.getOnboardingGoals();

        result.fold(
              (_) => fail('Expected Right but got Left'),
              (goals) => expect(goals.single.id, isEmpty),
        );
      });

      test('falls back to default icon when "icon" key is absent', () async {
        when(
              () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
        ).thenAnswer((_) async => const Right([
          {
            'id': 'goal_xyz',
            'title': {'en': 'Run Fast'},
            'subtitle': {'en': 'Improve your speed.'},
          }
        ]));

        final result = await firestoreOnboardingService.getOnboardingGoals();

        result.fold(
              (_) => fail('No Documents'),
              (goals) => expect(goals.single.icon, equals('fitness_center')),
        );
      });

      test('returns correct localized title and subtitle', () async {
        when(
              () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
        ).thenAnswer((_) async => const Right([
          {
            'id': 'goal_001',
            'title': {'en': 'Build Muscle', 'ar': 'بناء العضلات'},
            'subtitle': {'en': 'Focus on hypertrophy.', 'ar': 'التركيز على ضخامة العضلات.'},
            'icon': 'fitness_center',
          }
        ]));

        final result = await firestoreOnboardingService.getOnboardingGoals();

        result.fold(
              (_) => fail('No Documents'),
              (goals) {
            expect(goals.single.getTitle('en'), equals('Build Muscle'));
            expect(goals.single.getTitle('ar'), equals('بناء العضلات'));
            expect(goals.single.getSubtitle('en'), equals('Focus on hypertrophy.'));
          },
        );
      });

      test('falls back to English when requested language is not available',
              () async {
            when(
                  () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
            ).thenAnswer((_) async => const Right([
              {
                'id': 'goal_001',
                'title': {'en': 'Build Muscle'},
                'subtitle': {'en': 'Focus on hypertrophy.'},
                'icon': 'fitness_center',
              }
            ]));

            final result = await firestoreOnboardingService.getOnboardingGoals();

            result.fold(
                  (_) => fail('No Documents'),
                  (goals) => expect(goals.single.getTitle('fr'), equals('Build Muscle')),
            );
          });
    });

    group('Failure -', () {
      test('returns Left with ServerFailure when Firestore call fails',
              () async {
            final tFailure = ServerFailure('No Documents');

            when(
                  () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
            ).thenAnswer((_) async => Left(tFailure));

            final result = await firestoreOnboardingService.getOnboardingGoals();

            expect(result.isLeft(), isTrue);
            result.fold(
                  (failure) => expect(failure, equals(tFailure)),
                  (_) => fail('No Documents'),
            );
          });

      test('returns Left with ServerFailure when device is offline', () async {
        final tFailure = ServerFailure('No internet connection');

        when(
              () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
        ).thenAnswer((_) async => Left(tFailure));

        final result = await firestoreOnboardingService.getOnboardingGoals();

        expect(result.isLeft(), isTrue);
        result.fold(
              (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure, equals(tFailure));
          },
              (_) => fail('No Documents'),
        );
      });
    });

    group('Call  exactly once -', () {
      test('calls getCollection with the correct path exactly once', () async {
        when(
              () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
        ).thenAnswer((_) async => Right(tGoalMaps));

        await firestoreOnboardingService.getOnboardingGoals();

        verify(
              () => mockFirestoreService.getCollection(path: 'onboardingGoal'),
        ).called(1);
        // متعملش أي calls تانية غير اللي أنا متوقعها
      });
    });
  });
}
