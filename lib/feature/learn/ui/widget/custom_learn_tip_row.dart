import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/model/tip_model.dart';


class CustomLearnTipRow extends StatelessWidget {
  final int index;
  final TipModel tip;
  final bool isSaved;
  final bool showDivider;
  final ValueChanged<int> onToggleSave;

  const CustomLearnTipRow({
    super.key,
    required this.index,
    required this.tip,
    required this.isSaved,
    required this.showDivider,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (index + 1).toString().padLeft(2, '0'),
                style: AppTextStyles.font12Medium(context).copyWith(
                  color: AppColors.greySecondary,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(context, tip.titleKey),
                      style: AppTextStyles.font14SemiBold(context).copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      tr(context, tip.descKey),
                      style: AppTextStyles.font12Medium(context).copyWith(
                        color: AppColors.greySecondary,
                        height: 1.5,
                      ),
                    ),
                    8.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: tip.category.tagBg,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        tr(context, tip.category.labelKey).toUpperCase(),
                        style: AppTextStyles.font10Bold(context).copyWith(
                          color: tip.category.tagTextColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              8.horizontalSpace,
              GestureDetector(
                onTap: () => onToggleSave(index),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isSaved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    key: ValueKey(isSaved),
                    size: 20.sp,
                    color: isSaved ? AppColors.black : AppColors.greyTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.5,
            color: AppColors.border,
            indent: 20.w,
            endIndent: 20.w,
          ),
      ],
    );
  }
}