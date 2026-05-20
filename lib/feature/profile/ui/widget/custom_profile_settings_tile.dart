import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomProfileSettingsTile extends StatelessWidget {
  const CustomProfileSettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.iconBgColor,
    this.iconColor,
    this.titleColor,
    this.trailingColor,
    this.onTap,
    this.showExternalLink = false,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final Color? iconBgColor;
  final Color? iconColor;
  final Color? titleColor;
  final Color? trailingColor;
  final VoidCallback? onTap;
  final bool showExternalLink;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final effectiveTitleColor = titleColor ?? AppColors.black;
    final effectiveTrailingColor = trailingColor ?? AppColors.grey;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: iconBgColor ?? AppColors.white2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? AppColors.moreGrey,
                    size: 20,
                  ),
                ),
                14.horizontalSpace,
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.font14SemiBold(context).copyWith(
                      color: effectiveTitleColor,
                    ),
                  ),
                ),
                if (trailingText != null) ...[
                  Text(
                    trailingText!,
                    style: AppTextStyles.font14Regular(context).copyWith(
                      color: effectiveTrailingColor,
                    ),
                  ),
                  6.horizontalSpace,
                ],
                Icon(
                  showExternalLink
                      ? Icons.open_in_new_rounded
                      : Icons.chevron_right_rounded,
                  color: effectiveTrailingColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            indent: 70,
            color: AppColors.white4,
          ),
      ],
    );
  }
}
