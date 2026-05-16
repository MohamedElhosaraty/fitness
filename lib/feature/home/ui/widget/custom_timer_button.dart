import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomTimerButton extends StatelessWidget {
  const CustomTimerButton({
    super.key,
    required this.isTimerRunning,
    required this.timerLabel,
    required this.timerColor,
    required this.toggleTimer,
  });

  final bool isTimerRunning;
  final String timerLabel;
  final Color timerColor;
  final void Function() toggleTimer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: toggleTimer,
        icon: Icon(
          isTimerRunning ? Icons.timer : Icons.timer_outlined,
          size: 18,
        ),
        label: Text(timerLabel),
        style: ElevatedButton.styleFrom(
          backgroundColor: timerColor,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.font14Medium(
            context,
          ).copyWith(letterSpacing: 0.2),
          elevation: 0,
        ),
      ),
    );
  }
}
