import 'package:flutter/material.dart';

import '../../../../core/theming/app_text_styles.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "ProgressView",
        style: AppTextStyles.font26Bold(context),
      ),
    )  ;
  }
}
