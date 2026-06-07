import 'package:fitness/core/routing/routes.dart';
import 'package:flutter/material.dart';
import '../../feature/home/ui/page/active_exercise_screen.dart';
import '../../feature/main_screen/ui/main_screen.dart';
import '../../feature/onboarding/data/model/workout_exercise_model.dart';
import '../../feature/onboarding/ui/page/onboarding_screen.dart';
import '../../feature/splash/splash_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case Routes.activeExerciseScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ActiveExerciseScreen(
            dayExerciseModel: args['exercises'] as List<WorkoutExerciseModel>,
            currentSlot: args['currentSlot'] as int?,
          ),
        );
    }
    return null;
  }
}
