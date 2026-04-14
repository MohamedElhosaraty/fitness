import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../domain/entity/workout_category.dart';

class CustomCategoryDropdown extends StatelessWidget {
  const CustomCategoryDropdown({super.key,required this.selected, required this.categories,required this.onChanged});

  final WorkoutCategory? selected;
  final List<WorkoutCategory> categories;
  final ValueChanged<WorkoutCategory?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<WorkoutCategory>(
      initialValue: selected,
      hint: Text(
        'Select category...',
        style: AppTextStyles.font14Medium(context)
            .copyWith(color: AppColors.hint),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: AppColors.primaryColor, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.background,
      ),
      items: categories.map((gem) {
        return DropdownMenuItem(
          value: gem,
          child: Text(
            gem.label,
            style: AppTextStyles.font14Medium(context)
                .copyWith(color: AppColors.primaryColor),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
