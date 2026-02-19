
import 'dart:async';

import 'package:fitness/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/app_colors.dart';
import '../../core/theming/app_text_styles.dart';
import '../../generated/assets.dart';
import '../auth/data/service/firebase_auth_service.dart';


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
      var isLoggedIn = FirebaseAuthServices().isLoggedIn();
      if(isLoggedIn){
        context.pushReplacementNamed(Routes.signInView);
      }else{
        context.pushReplacementNamed(Routes.signUpView);
      }
    });
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
            "FitFlow",style: AppTextStyles.font48Bold(context).copyWith(
              color: AppColors.background,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          )
          ),
          Text(
            "Elevate Your Movement",style: AppTextStyles.font19Bold(context).copyWith(
              color: AppColors.lightGrey,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.4),
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
