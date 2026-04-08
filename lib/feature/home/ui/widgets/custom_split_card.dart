import 'package:fitness/feature/home/ui/widgets/custom_split_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomSplitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<CustomSplitButton> buttons;

  const CustomSplitCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: AppColors.grey.withValues(alpha: .4),),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.font19Bold(context)
                .copyWith(color: AppColors.darkBlue),
          ),
          6.verticalSpace,
          Text(
            subtitle,
            style: AppTextStyles.font14Regular(context)
                .copyWith(color: Colors.grey),
          ),
          16.verticalSpace,
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: buttons,
          ),
        ],
      ),
    );
  }
}
