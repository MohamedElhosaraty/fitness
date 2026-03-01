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
    // جلب المستخدم النشط حالياً (الذي تم اختياره أو سجل دخوله مؤخراً)
    final user = getUser();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${user?.name ?? 'User'} 👋",
              style: AppTextStyles.font20Bold(context)
                  .copyWith(color: AppColors.darkBlue),
            ),
            4.verticalSpace,
            Text(
              "Good morning",
              style: AppTextStyles.font13Bold(context)
                  .copyWith(color: AppColors.moreGrey),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.moreGrey.withOpacity(0.1),
          backgroundImage: _getProfileImage(user?.imageUrl),
        ),
      ],
    );
  }

  // ميثود ذكية لتحديد مصدر الصورة (رابط أم ملف محلي)
  ImageProvider _getProfileImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde");
    }

    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl); // إذا كان رابط من Firebase Storage
    }

    return FileImage(File(imageUrl)); // إذا كان مسار ملف محلي
  }
}