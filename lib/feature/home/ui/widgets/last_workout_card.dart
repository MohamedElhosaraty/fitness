import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:fitness/feature/home/ui/widgets/last_workout_view_all.dart';
import 'package:fitness/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LastWorkoutCard extends StatelessWidget {
  const LastWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LastWorkoutViewAll(),
        16.verticalSpace,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  Assets.imagesBodyWorkout,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upper Body",
                      style: AppTextStyles.font16Bold(context).copyWith(
                        color: AppColors.black,
                      )
                    ),
                    4.verticalSpace,
                    Text(
                      "Yesterday • 52 mins",
                      style: AppTextStyles.font14Regular(context).copyWith(
                        color: AppColors.moreGrey,
                      )
                    ),
                    8.verticalSpace,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 1,
                        minHeight: 6,
                        backgroundColor: AppColors.primaryColor.withValues(alpha: 0.2),
                        valueColor: AlwaysStoppedAnimation(
                            AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              8.horizontalSpace,
              Icon(
                Icons.check_circle,
                color: AppColors.green,
              )
            ],
          ),
        ),
        20.verticalSpace,
      ],
    );
  }
}
