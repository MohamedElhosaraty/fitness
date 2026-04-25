import 'package:fitness/core/routing/routes.dart';
import 'package:fitness/feature/auth/ui/page/signin_view.dart';
import 'package:fitness/feature/auth/ui/page/signup_view.dart';
import 'package:fitness/feature/home/ui/page/choose_training_split_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/home/data/model/day_schedule_model.dart';
import '../../feature/home/domain/entity/training_split_type.dart';
import '../../feature/home/ui/cubit/add_exercises/add_exercises_cubit.dart';
import '../../feature/home/ui/cubit/get_exercises/get_exercises_cubit.dart';
import '../../feature/home/ui/page/select_exercises_view.dart';
import '../../feature/home/ui/page/weekly_schedule_screen.dart';
import '../../feature/main_screen/ui/main_screen.dart';
import '../../feature/onboarding/ui/page/onboarding_screen.dart';
import '../../feature/splash/splash_screen.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

     case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.signInView:
        return MaterialPageRoute(builder: (_) => const SigninView());

      case Routes.signUpView:
        return MaterialPageRoute(builder: (_) => const SignupView());

      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case Routes.chooseTrainingSplitView:
        return MaterialPageRoute(builder: (_) => const ChooseTrainingSplitView());

      case Routes.weeklyScheduleScreen:
        final splitType = settings.arguments as TrainingSplitType;
        final exercisesCubit = getIt<GetExercisesCubit>();
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => exercisesCubit,
            child: WeeklyScheduleScreen(splitType: splitType),
          ),
        );

      case Routes.selectExercisesView:
        final args = settings.arguments as Map<String, dynamic>;
        final cubit = args['cubit'] as GetExercisesCubit;
        final day = args['day'] as DayScheduleModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: cubit),
              BlocProvider(create: (_) => getIt<AddExercisesCubit>()),
            ],
            child: SelectExercisesView(daySchedule: day),
          ),
        );
    }
    return null;
  }
}