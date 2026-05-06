import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/user_preferences.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';
import '../cubit/workout_cubit/workout_cubit.dart';
import '../cubit/workout_cubit/workout_state.dart';

class CustomNumberDay extends StatelessWidget {
  const CustomNumberDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr(context, AppStrings.weeklyBlueprint),
              style: AppTextStyles.font16Bold(
                context,
              ).copyWith(color: AppColors.black),
            ),
            Text(
              tr(context, AppStrings.week1),
              style: AppTextStyles.font14Medium(context),
            ),
          ],
        ),
        14.verticalSpace,
        BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            final int completedDays =
                state is WorkoutSuccess
                    ? state.completedDays
                    : UserPreferences.completedDays;
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white3,
                border: Border.all(color: AppColors.border, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(UserPreferences.numberDays, (index) {
                  final bool isCompleted = index + 1 < completedDays;
                  final bool isCurrent = index + 1 == completedDays;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 38.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      color:
                          isCompleted
                              ? AppColors.green
                              : isCurrent
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withValues(alpha: 0.30),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child:
                          isCompleted
                              ? const Icon(
                                Icons.check,
                                color: AppColors.background,
                                size: 18,
                              )
                              : Text(
                                '${index + 1}',
                                style: AppTextStyles.font14Medium(
                                  context,
                                ).copyWith(color: AppColors.background),
                              ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}
