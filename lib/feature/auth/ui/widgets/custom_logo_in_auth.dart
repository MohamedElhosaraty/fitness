import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/assets.dart';

class CustomLogoInAuth extends StatelessWidget {
  const CustomLogoInAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          Assets.svgsLogo,
          colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
        Text(
            "FitFlow",
            textAlign: TextAlign.center,
            style: AppTextStyles.font48Bold(context).copyWith(
              color: AppColors.primaryColor,
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
    );
  }
}
