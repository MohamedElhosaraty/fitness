import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomAddSet extends StatefulWidget {
  const CustomAddSet({
    super.key,
    required this.value,
    required this.isActive,
    this.onWeightChanged,
    this.isEditable = true,
  });

  final String value;
  final bool isActive;
  final bool isEditable;
  final ValueChanged<double>? onWeightChanged;

  @override
  State<CustomAddSet> createState() => _CustomAddSetState();
}

class _CustomAddSetState extends State<CustomAddSet> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (!widget.isActive) return;
    if (!widget.isEditable) return;
    setState(() => _isEditing = true);
  }

  void _onSubmit() {
    final newWeight = double.tryParse(_controller.text);
    if (newWeight != null) {
      widget.onWeightChanged?.call(newWeight);
    } else {
      _controller.text = widget.value;
    }
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Center(
        child: Container(
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
          child: _isEditing
              ? TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular(context).copyWith(
              color: AppColors.primaryColor,
            ),
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
            style: AppTextStyles.font14Regular(context).copyWith(
              color: widget.isActive
                  ? AppColors.primaryColor
                  : AppColors.greySecondary,
            ),
          ),
        ),
      ),
    );
  }
}
