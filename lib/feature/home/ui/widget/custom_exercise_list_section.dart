import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/exercise_icons.dart';
import '../../../../core/helpers/extensions.dart';
import '../../data/model/day_exercise_model.dart';
import 'custom_exercise_card.dart';

class CustomExerciseListSection extends StatelessWidget {
  const CustomExerciseListSection({super.key, required this.dayExercise});

  final DayExerciseModel dayExercise;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dayExercise.exerciseRefs.length,
      separatorBuilder: (_, __) => 12.verticalSpace,
      itemBuilder: (context, index) {
        final exercise = dayExercise.exerciseRefs[index];
        final icon = exerciseIcons[index % exerciseIcons.length];
        return CustomExerciseCard(
          name: exercise.getTitle(context.currentLang),
          muscle: exercise.getSubtitle(context.currentLang),
          repsDisplay: exercise.repsDisplay,
          icon: icon,
        );
      },
    );
  }
}
