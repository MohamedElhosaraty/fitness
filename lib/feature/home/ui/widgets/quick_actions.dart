import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:fitness/feature/home/ui/widgets/action_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: AppTextStyles.font19Bold(context).copyWith(
            color: AppColors.black,
          ),
        ),
        16.verticalSpace,
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: const [
            ActionCard(
                icon: Icons.flash_on, title: "Quick Start",
                color: AppColors.primaryColor),
            ActionCard(icon: Icons.calendar_today, title: "Schedule",
                color: AppColors.violet),
            ActionCard(icon: Icons.history, title: "History",
                color: AppColors.green),
            ActionCard(icon: Icons.explore, title: "Browse",
                color: AppColors.orange),
          ],
        )
      ],
    );
  }
}
