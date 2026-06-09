import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/app_strings.dart';
import '../../../onboarding/data/model/workout_day_model.dart';

class CustomContentActivePlanCard extends StatelessWidget {
  const CustomContentActivePlanCard({
    super.key,
    required this.dayExerciseModel,
    required this.currentSlot,
    required this.onWorkoutFinished,
  });

  final WorkoutDayModel dayExerciseModel;
  final int? currentSlot;
  final VoidCallback onWorkoutFinished;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dayExerciseModel.getTitle(context.currentLang),
          style: AppTextStyles.font26Bold(
            context,
          ).copyWith(color: AppColors.black),
        ),
        12.verticalSpace,
        Row(
          children: [
            const Icon(
              Icons.timer_outlined,
              size: 17,
              color: AppColors.moreGrey,
            ),
            5.horizontalSpace,
            Text(
              '45 ${tr(context, AppStrings.minutes)}',
              style: AppTextStyles.font14Regular(
                context,
              ).copyWith(color: AppColors.moreGrey),
            ),
            18.horizontalSpace,
            const Icon(
              Icons.grid_view_rounded,
              size: 17,
              color: AppColors.moreGrey,
            ),
            5.horizontalSpace,
            Text(
              '${dayExerciseModel.workoutExercises.length} ${tr(context, AppStrings.exercises)}',
              style: AppTextStyles.font14Regular(
                context,
              ).copyWith(color: AppColors.moreGrey),
            ),
          ],
        ),
        20.verticalSpace,
        if (currentSlot != null)
          CustomButton(
            yPadding: 20.h,
            borderRadius: 35.r,
            onPressed: () async {
              await context.pushNamed(
                Routes.activeExerciseScreen,
                arguments: {
                  'exercises': dayExerciseModel.workoutExercises,
                  'currentSlot': currentSlot,
                },
              );
              onWorkoutFinished();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr(context, AppStrings.startWorkout),
                  style: AppTextStyles.font19Bold(
                    context,
                  ).copyWith(color: AppColors.background),
                ),
                8.horizontalSpace,
                const Icon(
                  Icons.play_arrow_rounded,
                  size: 25,
                  color: AppColors.background,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
