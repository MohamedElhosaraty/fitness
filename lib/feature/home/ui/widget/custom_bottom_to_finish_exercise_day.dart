import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/workout_cubit/workout_cubit.dart';

class CustomBottomToFinishExerciseDay extends StatelessWidget {
  const CustomBottomToFinishExerciseDay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        context.read<WorkoutCubit>().completeDay();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr(context, 'finishExercise'),
            style: AppTextStyles.font19Bold(
              context,
            ).copyWith(color: AppColors.background),
          ),
          8.horizontalSpace,
          Icon(
            Icons.play_arrow_rounded,
            size: 25,
            color: AppColors.background,
          ),
        ],
      ),
    );
  }
}
