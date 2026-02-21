import 'package:fitness/core/helpers/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account?   ",
            style: AppTextStyles.font19Bold(
              context,
            ).copyWith(color: AppColors.darkBlue),
          ),
          TextSpan(
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    context.pushReplacementNamed(Routes.signUpView);

                  },
            text: "Sign Up",style: AppTextStyles.font16Bold(context).copyWith(
            color: AppColors.primaryColor,
          ),
          ),
        ],
      ),
    );
  }
}
