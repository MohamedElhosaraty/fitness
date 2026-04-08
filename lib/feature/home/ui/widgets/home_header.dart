import 'dart:io';

import 'package:fitness/core/helpers/get_user.dart';
import 'package:fitness/core/theming/app_colors.dart';
import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${getUser().name} 👋",
              style: AppTextStyles.font20Bold(
                context,
              ).copyWith(color: AppColors.darkBlue),
            ),
            4.verticalSpace,
            Text(
              "Good morning",
              style: AppTextStyles.font13Bold(
                context,
              ).copyWith(color: AppColors.moreGrey),
            ),
          ],
        ),
        // CircleAvatar(
        //   radius: 24,
        //   backgroundColor: AppColors.moreGrey.withOpacity(0.1),
        //   backgroundImage: FileImage(File((getUser().imageUrl.toString()))),
        // ),
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.moreGrey.withValues(alpha: 0.1),
          backgroundImage: _getUserImage(getUser().imageUrl),
        ),
      ],
    );
  }
  ImageProvider _getUserImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const AssetImage('assets/images/default_user.png'); // صورة افتراضية من الأصول
    }

    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl); // إذا كان رابطاً
    }

    // إذا كان مسار ملف محلي (تأكد من عمل import 'dart:io')
    return FileImage(File(imageUrl));
  }
}
