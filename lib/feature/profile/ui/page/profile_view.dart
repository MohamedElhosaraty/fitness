import 'package:flutter/material.dart';

import '../../../../core/theming/app_text_styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "ProfileView",
        style: AppTextStyles.font26Bold(context),
      ),
    )  ;
  }
}
