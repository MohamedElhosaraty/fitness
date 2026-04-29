import 'package:flutter/material.dart';

import '../../../../core/theming/app_text_styles.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Learn Screen",
        style: AppTextStyles.font26Bold(context),
      ),
    )  ;
  }
}
