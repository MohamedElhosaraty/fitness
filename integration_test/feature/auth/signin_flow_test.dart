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

  group('Integration Test - Sign In Flow', () {
    testWidgets('sign in and show loading', (WidgetTester tester) async {
      AuthRobot chatRobot = AuthRobot(tester: tester);
      when(
        () => authMockRepo.signInWithEmailAndPassword(any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return Right(
          UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
        );
      });

      await chatRobot.runApp(widgetScreen: const SigninView());
      await chatRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'HelloMohamed@gmail.com',
      );
      await chatRobot.enterText(
        key: const Key('passwordSignIn'),
        text: 'Hello1234567',
      );
      await chatRobot.sendButton(key: const Key('signInButton'));
      await tester.pump();
      expect(find.byKey(const Key('loadingSignInScreen')), findsOneWidget);
    });

    testWidgets('Sign in success - shows loading then navigates to home', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);

      when(
        () => authMockRepo.signInWithEmailAndPassword(any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return Right(
          UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
        );
      });

      await authRobot.runApp(widgetScreen: const SigninView());
      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'Mohamed@gmail.com',
      );
      await authRobot.enterText(
        key: const Key('passwordSignIn'),
        text: 'Password123',
      );
      await authRobot.sendButton(key: const Key('signInButton'));
      await tester.pumpAndSettle();
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('Sign in failure - shows server error toast', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      const String errorMessage = "Server error, please try again later";
      when(
        () => authMockRepo.signInWithEmailAndPassword(any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return Left(ServerFailure(errorMessage));
      });

      await authRobot.runApp(widgetScreen: const SigninView());
      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'test@gmail.com',
      );
      await authRobot.enterText(
        key: const Key('passwordSignIn'),
        text: '123456',
      );
      await authRobot.sendButton(key: const Key('signInButton'));
      await tester.pumpAndSettle();
      expect(find.byType(SigninView), findsOneWidget);
    });

    testWidgets('Invalid email - show validation message', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      when(
            () => authMockRepo.signInWithEmailAndPassword(any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return Right(
          UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
        );
      });

      await authRobot.runApp(widgetScreen: const SigninView());

      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'testgmail.com',
      );

      await authRobot.enterText(
        key: const Key('passwordSignIn'),
        text: '123456',
      );

      await authRobot.sendButton(key: const Key('signInButton'));

      await tester.pump();
      expect(find.text("Please Enter a valid email"), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));


      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'Mohamed@gmail.com',
      );

      await authRobot.enterText(
        key: const Key('passwordSignIn'),
        text: '123456',
      );

      await authRobot.sendButton(key: const Key('signInButton'));

      await tester.pumpAndSettle();

      expect(find.byType(MainScreen), findsOneWidget);

    });

    testWidgets('email is empty - show validation message', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      when(
            () => authMockRepo.signInWithEmailAndPassword(any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return Right(
          UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
        );
      });

      await authRobot.runApp(widgetScreen: const SigninView());

      await authRobot.enterText(
        key: const Key('passwordSignIn'),
        text: '123456',
      );

      await authRobot.sendButton(key: const Key('signInButton'));

      await tester.pump();
      expect(find.text("Please Enter a valid email"), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));


      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'Mohamed@gmail.com',
      );

      await authRobot.enterText(
        key: const Key('passwordSignIn'),
        text: '123456',
      );

      await authRobot.sendButton(key: const Key('signInButton'));

      await tester.pumpAndSettle();

      expect(find.byType(MainScreen), findsOneWidget);

    });

    testWidgets('password is empty - show validation message', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      when(
            () => authMockRepo.signInWithEmailAndPassword(any(), any()),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 2));
        return Right(
          UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
        );
      });

      await authRobot.runApp(widgetScreen: const SigninView());

      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'test@gmail.com',
      );

      // await authRobot.enterText(
      //   key: const Key('passwordSignIn'),
      //   text: '123456',
      // );

      await authRobot.sendButton(key: const Key('signInButton'));

      await tester.pump();
      expect(find.text("Enter a valid password"), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));


      await authRobot.enterText(
        key: const Key('passwordSignIn'),
        text: '123456',
      );

      await authRobot.sendButton(key: const Key('signInButton'));

      await tester.pumpAndSettle();

      expect(find.byType(MainScreen), findsOneWidget);

    });

    testWidgets('Sign in - fails twice then succeeds on third attempt', (WidgetTester tester,) async {
      AuthRobot authRobot = AuthRobot(tester: tester);
      int callCount = 0;
      when(
        () => authMockRepo.signInWithEmailAndPassword(any(), any()),
      ).thenAnswer((_) async {
        callCount++;
        await Future.delayed(const Duration(milliseconds: 500));
        if (callCount < 3) {
          return Left(ServerFailure("This Email or Password is not correct $callCount"));
        } else {
          return Right(
            UserModel(email: "test@test.com", name: "Mohamed", uId: "123"),
          );
        }
      });

      await authRobot.runApp(widgetScreen: const SigninView());

      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'test@gmail.com',
      );
      await authRobot.enterText(
        key: const Key('passwordSignIn'),
        text: '123456',
      );
      await authRobot.sendButton(key: const Key('signInButton'));
      await tester.pumpAndSettle();

      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'test5555555555@gmail.com',
      );
      await authRobot.sendButton(key: const Key('signInButton'));
      await tester.pumpAndSettle();

      await authRobot.enterText(
        key: const Key('emailSignIn'),
        text: 'mohamed@gmail.com',
      );
      await authRobot.sendButton(key: const Key('signInButton'));
      await tester.pumpAndSettle();

      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('sign in and dont have an account', (WidgetTester tester) async {
      AuthRobot authRobot = AuthRobot(tester: tester);

      await authRobot.runApp(widgetScreen: const SigninView());
      await authRobot.sendButton(key: const Key('signUpButtonDontHaveAnAccount'));
      await tester.pumpAndSettle();
      expect(find.byType( SignupView), findsOneWidget);
    });

  });
}
