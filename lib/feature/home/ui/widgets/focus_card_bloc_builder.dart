import 'package:fitness/core/helpers/get_today_name.dart';
import 'package:fitness/feature/home/ui/widgets/custom_dotted_border.dart';
import 'package:fitness/feature/home/ui/widgets/custom_focus_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../cubit/get_day_exercises/get_day_exercises_cubit.dart';
import 'focus_card_shimmer.dart';

class FocusCardBlocBuilder extends StatelessWidget {
  const FocusCardBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Today's Workout • ${GetTodayName.getTodayName()}",
                style: AppTextStyles.font14Regular(context)
                    .copyWith(color: AppColors.moreGrey),
              ),
              const Spacer(),
              InkWell(
                onTap: () => context.pushNamed(Routes.chooseTrainingSplitView),
                child: Row(
                  children: [
                    Text(
                      "Schedule",
                      style: AppTextStyles.font16Bold(context),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.primaryColor,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          12.verticalSpace,
          BlocBuilder<GetDayExercisesCubit, GetDayExercisesState>(
            builder: (context, state) {
              if (state is GetDayExercisesLoading) return const FocusCardShimmer();
              if (state is GetDayExercisesSuccess) {
                return  CustomFocusCard(day: state.day);
              }
              return CustomDottedBorder();
            },
          ),

        ],
      ),
    );
  }
}
