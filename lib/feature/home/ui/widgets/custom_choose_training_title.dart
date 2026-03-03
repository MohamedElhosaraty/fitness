import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomChooseTrainingTitle extends StatelessWidget {
  const CustomChooseTrainingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.darkBlue,
            size: 30,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Choose Training Split",
              style: AppTextStyles.font20Bold(
                context,
              ).copyWith(color: AppColors.darkBlue),
            ),
          ),
        ),
      ],
    );
  }
}
