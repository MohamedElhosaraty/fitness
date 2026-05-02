import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomDayItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int itemIndex;


  const CustomDayItem({
    super.key,
    required this.label,
    required this.itemIndex,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          key: isSelected ? Key('dayItemSelected_$itemIndex') : null,
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4 ),
          padding: const EdgeInsets.symmetric(vertical: 11),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.font12Medium(context).copyWith(
              color: isSelected ? AppColors.background : AppColors.moreGrey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}