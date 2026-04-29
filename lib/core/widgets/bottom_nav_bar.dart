import 'package:fitness/core/localization/localization_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../theming/app_colors.dart';
import '../theming/app_text_styles.dart';

class MyBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MyBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(top: 10.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.grey.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        iconSize: 24,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.svgsHome),
            activeIcon: SvgPicture.asset(Assets.svgsHome, colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
            label: tr(context, "home"),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.svgsLearn),
            activeIcon: SvgPicture.asset(Assets.svgsLearn, colorFilter:const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
            label: tr(context, "learn"),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.svgsProfile),
            activeIcon: SvgPicture.asset(Assets.svgsProfile, colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
            label: tr(context, "profile"),
          ),
        ],
        unselectedItemColor: AppColors.grey,
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: AppTextStyles.font10Bold(context),
        unselectedLabelStyle: AppTextStyles.font10Medium(context),
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: AppColors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}