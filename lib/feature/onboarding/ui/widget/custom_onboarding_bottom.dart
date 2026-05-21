import 'package:fitness/core/helpers/extensions.dart';
import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/core/widgets/custom_button.dart';
import 'package:fitness/feature/home/ui/cubit/workout_cubit/workout_cubit.dart';
import 'package:fitness/feature/onboarding/ui/cubit/save_workout_plan/save_workout_plan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';

class CustomOnboardingBottom extends StatelessWidget {
  const CustomOnboardingBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveWorkoutPlanCubit, SaveWorkoutPlanState>(
      listener: (context, state) {
        if (state is SaveWorkoutPlanSuccess) {
          context.read<WorkoutCubit>().loadCurrentDay();
          context.pushReplacementNamed(Routes.mainScreen);
        }
      },
      child: Column(
        children: [
          BlocBuilder<SaveWorkoutPlanCubit, SaveWorkoutPlanState>(
            builder: (context, state) {
              final isLoading = state is SaveWorkoutPlanLoading;
              return CustomButton(
                key: const Key('continueButton'),
                yPadding: 15,
                onPressed: isLoading
                    ? null
                    : () => context.read<SaveWorkoutPlanCubit>().saveWorkoutPlan(),

                child: isLoading
                    ? const CircularProgressIndicator(
                  color: AppColors.background,
                  strokeWidth: 2,
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr(context, AppStrings.continueKey),
                      style: AppTextStyles.font16Bold(context)
                          .copyWith(color: AppColors.background),
                    ),
                    8.horizontalSpace,
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: AppColors.background,
                    ),
                  ],
                ),
              );
            },
          ),
          10.verticalSpace,
          Text(
            tr(context, AppStrings.changeLater),
            style: AppTextStyles.font10Medium(context)
                .copyWith(color: AppColors.grey, letterSpacing: 0.6),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}