import 'package:dartz/dartz.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/feature/auth/data/model/user_model.dart';
import 'package:fitness/feature/auth/ui/page/signin_view.dart';
import 'package:fitness/feature/auth/ui/page/signup_view.dart';
import 'package:fitness/feature/main_screen/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/test_setup.dart';
import 'robot/auth_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await setupAuthTest();
  });

  group('Integration Test - Signup Flow', () {
    testWidgets('sign up and show loading', (WidgetTester tester) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      when(() => authMockRepo.createUserWithEmailAndPassword(any(), any() , any() , any()))
          .thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return Right(
          UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
        );
      });

      await authRobot.runApp(widgetScreen: const SignupView());

      await tester.pumpAndSettle();
      await authRobot.enterText(key: const Key('nameSignUp'), text: 'Mohamed');
      await authRobot.enterText(
        key: const Key('emailSignUp'),
        text: 'HelloMohamed@gmail.com',
        scrollOffset: 200,
      );
      await authRobot.enterText(
        key: const Key('passwordSignUp'),
        text: 'Hello1234567',
      );

      await authRobot.sendButton(key: const Key('signUpButton'),);
      await tester.pump();

      expect(find.byKey(const Key('loadingSignupScreen')), findsOneWidget);
    });

    testWidgets('Sign Up success - shows loading then navigates to home', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);

      when(
            () => authMockRepo.createUserWithEmailAndPassword(any(), any(), any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return Right(
          UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
        );
      });

      await authRobot.runApp(widgetScreen: const SignupView());
      await authRobot.enterText(key: const Key('nameSignUp'), text: 'Mohamed');

      await authRobot.enterText(
        key: const Key('emailSignUp'),
        text: 'HelloMohamed@gmail.com',
        scrollOffset: 200,
      );
      await authRobot.enterText(
        key: const Key('passwordSignUp'),
        text: 'Hello1234567',
      );
      await authRobot.sendButton(key: const Key('signUpButton'));
      await tester.pumpAndSettle();
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('Sign Up failure - shows server error toast', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      const String errorMessage = "Server error, please try again later";
      when(
            () => authMockRepo.createUserWithEmailAndPassword(any(), any(), any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return Left(ServerFailure(errorMessage));
      });

      await authRobot.runApp(widgetScreen: const SignupView());
      await authRobot.enterText(key: const Key('nameSignUp'), text: 'Mohamed');
      await authRobot.enterText(
        key: const Key('emailSignUp'),
        text: 'HelloMohamed@gmail.com',
        scrollOffset: 200,
      );
      await authRobot.enterText(
        key: const Key('passwordSignUp'),
        text: 'Hello1234567',
      );
      await authRobot.sendButton(key: const Key('signUpButton'));
      await tester.pumpAndSettle();
      expect(find.byType(SignupView), findsOneWidget);
    });

    testWidgets('Invalid email - show validation message', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      when(
            () => authMockRepo.createUserWithEmailAndPassword(any(), any(), any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return Right(
          UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
        );
      });

      await authRobot.runApp(widgetScreen: const SignupView());

      await authRobot.enterText(key: const Key('nameSignUp'), text: 'test');
      await authRobot.enterText(
        key: const Key('emailSignUp'),
        text: 'HelloMohamedGmail.com',
        scrollOffset: 200,
      );
      await authRobot.enterText(
        key: const Key('passwordSignUp'),
        text: 'Hello1234567',
      );

      await authRobot.sendButton(key: const Key('signUpButton'));

      await tester.pump();
      expect(find.text("Please Enter a valid email"), findsOneWidget);
      await tester.pump(const Duration(seconds: 2));


      await authRobot.enterText(key: const Key('nameSignUp'), text: 'Mohamed');
      await authRobot.enterText(
        key: const Key('emailSignUp'),
        text: 'HelloMohamed@gmail.com',
      );
      await authRobot.enterText(
        key: const Key('passwordSignUp'),
        text: 'Hello1234567',
      );

      await authRobot.sendButton(key: const Key('signUpButton'));


      await tester.pumpAndSettle();

      expect(find.byType(MainScreen), findsOneWidget);

    });

    testWidgets('Sign up - fails twice then succeeds on third attempt', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      int callCount = 0;
      when(
            () => authMockRepo.createUserWithEmailAndPassword(any(), any(), any(),any()),
      ).thenAnswer((_) async {
        callCount++;
        await Future.delayed(const Duration(milliseconds: 500));
        if (callCount < 3) {
          return Left(ServerFailure("This Email is already in use $callCount"));
        } else {
          return Right(
            UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
          );
        }
      });

      await authRobot.runApp(widgetScreen: const SignupView());

      await authRobot.enterText(
          key: const Key('nameSignUp'), text: 'Mohamed');
      await authRobot.enterText(
        key: const Key('emailSignUp'),
        text: 'Hello@gmail.com',
        scrollOffset: 200,
      );
      await authRobot.enterText(
        key: const Key('passwordSignUp'),
        text: 'Hello1234567',
      );
      await authRobot.sendButton(key: const Key('signUpButton'));
      await tester.pumpAndSettle();

      await authRobot.enterText(
        key: const Key('emailSignUp'),
        text: 'Mohamed@gmail.com',
      );
      await authRobot.sendButton(
          key: const Key('signUpButton'),);
      await tester.pumpAndSettle();

      await authRobot.enterText(
        key: const Key('emailSignUp'),
        text: 'Mohamed55@gmail.com',
      );
      await authRobot.sendButton(key: const Key('signUpButton'));
      await tester.pumpAndSettle();

      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('sign up and have an account', (WidgetTester tester) async {
      AuthRobot authRobot = AuthRobot(tester: tester);

      await authRobot.runApp(widgetScreen: const SignupView());
      await authRobot.sendButton(key: const Key('signUpButtonHaveAnAccount'));
      await tester.pumpAndSettle();
      expect(find.byType( SigninView), findsOneWidget);
    });
  });
}
