import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';

class LastWorkoutViewAll extends StatelessWidget {
  const LastWorkoutViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Last Workout",
          style: AppTextStyles.font19Bold(context).copyWith(
            color: AppColors.black,
          )
        ),
        TextButton(
          onPressed: () {},
          child: Text("View All",style: AppTextStyles.font14Medium(context),),
        ),
      ],
    );
  }
}
