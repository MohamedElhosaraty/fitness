import 'package:dartz/dartz.dart';
import 'package:fitness/feature/home/data/model/day_exercise_model.dart';
import 'package:fitness/feature/main_screen/ui/main_screen.dart';
import 'package:fitness/feature/onboarding/data/model/onboarding_goal_model.dart';
import 'package:fitness/feature/onboarding/ui/page/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import 'robot/onboarding_robot.dart';
import 'helpers/test_setup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await setupOnboardingTest();
  });

  final tGoals = [
    OnboardingGoalModel(
      id: '1',
      title: {'en': 'Get Fit', 'ar': 'خسارة الوزن'},
      subtitle: {'en': 'Improve body', 'ar': 'حسّن جسمك'},
      icon: 'fitness_center',
    ),
    OnboardingGoalModel(
      id: '2',
      title: {'en': 'Build Muscle', 'ar': 'بناء عضلات'},
      subtitle: {'en': 'Gain strength', 'ar': 'زيادة القوة'},
      icon: 'directions_run',
    ),
    OnboardingGoalModel(id: '3',
        title: {'en': 'Lose Weight', 'ar': 'تخسيس'},
        subtitle: {'en': 'Gain strength', 'ar': 'زيادة القوة'}, icon: 'directions_run'),

  ];

  final tDayExercise = DayExerciseModel(
    category: {'en': 'Chest', 'ar': 'صدر'},
    exerciseRefs: [],
  );

  group('Integration Test - Onboarding Flow', () {
    testWidgets('select goal', (WidgetTester tester) async {
      OnboardingRobot authRobot = OnboardingRobot(tester: tester);

      when(() => onboardingMockRepo.getOnboardingGoals())
          .thenAnswer((_) async => Right(tGoals));

      await authRobot.runApp(widgetScreen: const OnboardingScreen());
      await tester.pumpAndSettle();

      await authRobot.tapItem(key: const Key('goalItem_1'));
      expect(find.byKey(const Key('goalItemSelected_1')), findsOneWidget);

    });

    testWidgets('select number of days ', (WidgetTester tester) async {
      OnboardingRobot authRobot = OnboardingRobot(tester: tester);
      when(() => onboardingMockRepo.getOnboardingGoals())
          .thenAnswer((_) async => Right(tGoals));

      await authRobot.runApp(widgetScreen: const OnboardingScreen());

      await tester.pumpAndSettle();

      await authRobot.tapItem(key: const Key('dayItem_3'),);
      await tester.pump();
      expect(find.byKey(Key('dayItemSelected_3')), findsOneWidget);
    });

    testWidgets('go to Main screen', (WidgetTester tester) async {
      OnboardingRobot authRobot = OnboardingRobot(tester: tester);

      when(() => onboardingMockRepo.getOnboardingGoals())
          .thenAnswer((_) async => Right(tGoals));

      when(() => workoutMockRepo.getExercisesForDay(any(), any(), any()))
          .thenAnswer((_) async => Right(tDayExercise));

      await authRobot.runApp(widgetScreen: const OnboardingScreen());
      await tester.pumpAndSettle();
      await authRobot.tapItem(key: const Key('goalItem_1'));
      await authRobot.tapItem(key: const Key('dayItem_3'),);
      await tester.pump();
      await authRobot.sendButton(key: const Key('continueButton'));
      await tester.pumpAndSettle();

      expect(find.byType(MainScreen), findsOneWidget);
    });
  });
}
