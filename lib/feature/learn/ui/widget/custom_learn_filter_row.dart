import 'package:fitness/feature/learn/ui/widget/custom_learn_filter_row_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../generated/app_strings.dart';
import '../../data/model/tip_model.dart';

class CustomLearnFilterRow extends StatelessWidget {
  final TipCategory? selected;
  final ValueChanged<TipCategory?> onSelected;

  const CustomLearnFilterRow({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = TipCategory.values
        .where((c) => c != TipCategory.saved)
        .toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          CustomLearnFilterRowChip(
            label: tr(context, AppStrings.all),
            isSelected: selected == null,
            onTap: () => onSelected(null),
          ),
          8.horizontalSpace,
          CustomLearnFilterRowChip(
            label: tr(context, AppStrings.saved),
            isSelected: selected == TipCategory.saved,
            onTap: () => onSelected(TipCategory.saved),
          ),
          8.horizontalSpace,
          ...categories.map(
                (val) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: CustomLearnFilterRowChip(
                label: tr(context, val.labelKey),
                isSelected: selected == val,
                onTap: () => onSelected(val),
              ),
            ),
          ),
        ],
      ),
    );
  }
}