import 'package:fitness/core/routing/routes.dart';
import 'package:flutter/material.dart';
import '../../feature/main_screen/ui/main_screen.dart';
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


    }
    return null;
  }
}