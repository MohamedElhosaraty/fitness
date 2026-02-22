import 'package:flutter/material.dart';

import '../../../../core/theming/app_text_styles.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "WorkoutView",
        style: AppTextStyles.font26Bold(context),
      ),
    )  ;
  }
}
