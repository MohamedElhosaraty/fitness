import 'package:flutter/material.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomRecommendedCard extends StatelessWidget {
  const CustomRecommendedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            color: AppColors.lighterGrey,
            child: const Icon(Icons.fitness_center, size: 64, color: AppColors.white3),
          ),
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.black.withValues(alpha: 0.55)],
              ),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 14,
            right: 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tr(context, 'recommended'),
                    style: AppTextStyles.font10Bold(context).copyWith(
                      color: AppColors.background,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                Text(
                  tr(context, "optimalRecovery"),
                  style: AppTextStyles.font12Medium(context).copyWith(color: AppColors.background),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
