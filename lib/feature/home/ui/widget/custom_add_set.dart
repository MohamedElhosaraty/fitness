import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/hive_helper.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomAddSet extends StatefulWidget {
  const CustomAddSet({
    super.key,
    required this.value,
    required this.isActive,
    required this.exerciseId,
    required this.setIndex,
    this.onWeightChanged,
    this.onRepsChanged,
  });

  final String value;
  final bool isActive;
  final String exerciseId;
  final int setIndex;
  final ValueChanged<double>? onWeightChanged;
  final ValueChanged<int>? onRepsChanged;

  @override
  State<CustomAddSet> createState() => _CustomAddSetState();
}

class _CustomAddSetState extends State<CustomAddSet> {
  late TextEditingController _controller;

  String get _cleanValue => widget.value.replaceAll('kg', '').trim();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _cleanValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomAddSet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = _cleanValue;
    }
  }

  void _onSubmit() async {
    final text = _controller.text.replaceAll('kg', '').trim();
    double? newWeight;
    int? newReps;

    if (widget.onWeightChanged != null) {
      newWeight = double.tryParse(text);
      if (newWeight == null) {
        _controller.text = _cleanValue;
        return;
      }
      widget.onWeightChanged?.call(newWeight);
    } else if (widget.onRepsChanged != null) {
      newReps = int.tryParse(text);
      if (newReps == null) {
        _controller.text = _cleanValue;
        return;
      }
      widget.onRepsChanged?.call(newReps);
    }

    await HiveHelper.updateSet(
      exerciseId: widget.exerciseId,
      setIndex: widget.setIndex,
      newWeight: newWeight,
      newReps: newReps,
    );

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: widget.isActive ? AppColors.background : AppColors.white4,
        border: Border.all(
          color: widget.isActive ? AppColors.primaryColor : AppColors.white4,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          widget.isActive
              ? TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Regular(
                  context,
                ).copyWith(color: AppColors.primaryColor),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onSubmitted: (_) => _onSubmit(),
                onTapOutside: (_) => _onSubmit(),
              )
              : Text(
                widget.value,
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Regular(
                  context,
                ).copyWith(color: AppColors.greySecondary),
              ),
    );
  }
}
