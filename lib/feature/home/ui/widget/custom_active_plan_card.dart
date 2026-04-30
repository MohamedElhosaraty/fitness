import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/feature/home/ui/widget/custom_content_bloc_builder_active_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/assets.dart';

class CustomActivePlanCard extends StatelessWidget {
  const CustomActivePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.background,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            top: 15.h,
            child: Image.asset(
              Assets.imagesActivePlanBackGround,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFEFF2F8).withValues(alpha: .90),
                    const Color(0xFFEFF2F8).withValues(alpha: .80),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.fitness_center_rounded,
                        color: AppColors.primaryColor,
                        size: 22,
                      ),
                    ),
                    12.horizontalSpace,
                    Text(
                      tr(context, 'activePlan'),
                      style: AppTextStyles.font14SemiBold(context),
                    ),
                  ],
                ),
                16.verticalSpace,
                const CustomContentBlocBuilderActivePlan(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
