
import 'dart:async';

import 'package:fitness/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/localization/localization_methods.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/app_colors.dart';
import '../../core/theming/app_text_styles.dart';
import '../../generated/app_strings.dart';
import '../../generated/assets.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.pushReplacementNamed(Routes.onboardingScreen);

      // final selectedDays = SharedPrefHelper.getInt(SharedPrefsKeys.selectedDays);
      // final selectedGoal = SharedPrefHelper.getString(SharedPrefsKeys.selectedGoal);
      // if (selectedDays == 0 || selectedGoal.isEmpty) {
      //   context.pushReplacementNamed(Routes.onboardingScreen);
      // }else{
      //   context.pushReplacementNamed(Routes.mainScreen);
      // }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              Assets.svgsLogo,
            ),
          ),
          Text(
            tr(context, AppStrings.fitFlow),style: AppTextStyles.font48Bold(context).copyWith(
              color: AppColors.background,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.4),
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          )
          ),
          Text(
            tr(context, AppStrings.elevateYourMovement),style: AppTextStyles.font19Bold(context).copyWith(
              color: AppColors.lightGrey,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.4),
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          )
          ),
        ],
      ),
    );
  }
}
