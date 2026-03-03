import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSplitButton extends StatelessWidget {
  final String text;
  final Color color;
  final String emoji;

  const CustomSplitButton({
    super.key,
    required this.text,
    required this.color,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji),
          6.horizontalSpace,
          Text(
            text,
            style: AppTextStyles.font14Medium(context)
                .copyWith(color: AppColors.background),
          ),
        ],
      ),
    );
  }
}
