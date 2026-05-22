import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../generated/app_strings.dart';
import 'custom_learn_stats_row_card.dart';

class CustomLearnStatsRow extends StatelessWidget {
  final int totalTips;
  final int savedCount;

  const CustomLearnStatsRow({
    super.key,
    required this.totalTips,
    required this.savedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomLearnStatsRowCard(
          value: '$totalTips',
          label: tr(context, AppStrings.totalTips),
        ),
        12.horizontalSpace,
        CustomLearnStatsRowCard(
          value: '$savedCount',
          label: tr(context, AppStrings.saved),
        ),
        12.horizontalSpace,
        CustomLearnStatsRowCard(
          value: '5',
          label: tr(context, AppStrings.categories),
        ),
        12.horizontalSpace,
        CustomLearnStatsRowCard(
          value: tr(context, AppStrings.expert),
          label: tr(context, AppStrings.level),
        ),
      ],
    );
  }
}