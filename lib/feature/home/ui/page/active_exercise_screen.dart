import 'package:fitness/feature/home/ui/widget/active_exercise_screen_body.dart';
import 'package:flutter/material.dart';
import '../../../onboarding/data/model/workout_exercise_model.dart';


class ActiveExerciseScreen extends StatelessWidget {
  const ActiveExerciseScreen({super.key, required this.dayExerciseModel});

  final List<WorkoutExerciseModel> dayExerciseModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ActiveExerciseScreenBody(
        dayExercise: dayExerciseModel,
      ),
    );
  }
}

