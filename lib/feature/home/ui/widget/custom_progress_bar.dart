import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({super.key, required this.timerProgress, required this.timerColor});

  final double timerProgress;
  final Color timerColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: LinearProgressIndicator(
        value: timerProgress,
        minHeight: 4,
        backgroundColor: AppColors.white4,
        valueColor: AlwaysStoppedAnimation<Color>(timerColor),
      ),
    );
  }
}
