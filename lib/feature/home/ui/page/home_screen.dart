import 'package:fitness/feature/home/ui/widget/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/workout_cubit/workout_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WorkoutCubit>()..loadCurrentDay(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: HomeScreenBody(),
      ),
    );
  }
}
