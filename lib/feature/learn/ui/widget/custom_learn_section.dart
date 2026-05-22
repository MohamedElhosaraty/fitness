import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';
import '../../data/model/tip_model.dart';
import 'custom_learn_tip_row.dart';


class CustomLearnSection extends StatelessWidget {
  final TipCategory category;
  final List<MapEntry<int, TipModel>> tips;
  final Set<int> savedIndices;
  final ValueChanged<int> onToggleSave;

  const CustomLearnSection({
    super.key,
    required this.category,
    required this.tips,
    required this.savedIndices,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    color: category.bgColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    category.icon,
                    size: 16.sp,
                    color: category.iconColor,
                  ),
                ),
                10.horizontalSpace,
                Text(
                  tr(context, category.labelKey),
                  style: AppTextStyles.font14SemiBold(context).copyWith(
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  '${tips.length} ${tr(context, AppStrings.tips)}',
                  style: AppTextStyles.font12Medium(context).copyWith(
                    color: AppColors.greySecondary,
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border(
                top: BorderSide(color: AppColors.border, width: 0.5),
                bottom: BorderSide(color: AppColors.border, width: 0.5),
              ),
            ),
            child: Column(
              children: tips.asMap().entries.map((entry) {
                final isLast = entry.key == tips.length - 1;
                return CustomLearnTipRow(
                  index: entry.value.key,
                  tip: entry.value.value,
                  isSaved: savedIndices.contains(entry.value.key),
                  showDivider: !isLast,
                  onToggleSave: onToggleSave,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}