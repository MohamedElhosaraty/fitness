import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/feature/home/data/model/workout_set.dart';
import 'package:fitness/feature/home/ui/widget/custom_add_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_text_styles.dart';

class CustomSetRow extends StatelessWidget {
  const CustomSetRow({
    super.key,
    required this.index,
    required this.sets,
    required this.exerciseId,
    required this.toggleDone,
    required this.onWeightChanged,
    required this.onRepsChanged,
  });

  final int index;
  final List<WorkoutSet> sets;
  final String exerciseId;
  final void Function(int index) toggleDone;
  final void Function(int index, double weight) onWeightChanged;
  final void Function(int index, int reps) onRepsChanged;

  @override
  Widget build(BuildContext context) {
    final set = sets[index];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: set.isActive ? AppColors.primaryColor.withValues(alpha: 0.1) : AppColors.transparent,
        border: index == sets.length - 1
            ? null
            : const Border(bottom: BorderSide(color: AppColors.white4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '  ${index + 1}',
              style: AppTextStyles.font14Medium(context)
                  .copyWith(color: AppColors.greySecondary),
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomAddSet(
              value      : '${set.weight} kg',
              isActive   : set.isActive,
              exerciseId : exerciseId,
              setIndex   : index,
              onWeightChanged: (newWeight) => onWeightChanged(index, newWeight),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            flex: 3,
            child: CustomAddSet(
              value      : '${set.reps}',
              isActive   : set.isActive,
              exerciseId : exerciseId,
              setIndex   : index,
              onRepsChanged: (newReps) => onRepsChanged(index, newReps),
            ),
          ),
          12.horizontalSpace,
          SizedBox(
            width: 50.w,
            child: GestureDetector(
              onTap: () => toggleDone(index),
              child: AnimatedContainer(
                duration  : const Duration(milliseconds: 200),
                width     : 30.w,
                height    : 30.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: set.isDone ? AppColors.greenSecondary : Colors.transparent,
                  border: Border.all(
                    color: set.isDone ? AppColors.greenSecondary : AppColors.greyTertiary,
                    width: 2,
                  ),
                ),
                child: set.isDone
                    ? const Icon(Icons.check, size: 16, color: AppColors.background)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}