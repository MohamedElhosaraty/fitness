import 'package:fitness/core/routing/routes.dart';
import 'package:fitness/feature/auth/ui/page/signin_view.dart';
import 'package:fitness/feature/auth/ui/page/signup_view.dart';
import 'package:flutter/material.dart';

import '../../feature/splash/splash_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
       return MaterialPageRoute(builder: (_) => const SplashScreen());

 case Routes.signInView:
       return MaterialPageRoute(builder: (_) => const SigninView());

 case Routes.signUpView:
       return MaterialPageRoute(builder: (_) => const SignupView());


    }
    return null;
  }
}
