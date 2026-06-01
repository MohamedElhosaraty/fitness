import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/profile_helpers.dart';
import '../../../../core/helpers/profile_image_storage.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomProfileAvatar extends StatelessWidget {
  const CustomProfileAvatar({
    super.key,
    required this.size,
    this.showEditButton = false,
    this.onEditTap,
    this.borderWidth = 3,
  });

  final double size;
  final bool showEditButton;
  final VoidCallback? onEditTap;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final name = profileUserName(context);
    final initials = profileInitials(name);

    return ValueListenableBuilder<({String? path, int version})>(
      valueListenable: ProfileImageStorage.imageNotifier,
      builder: (context, data, _) {
        final hasImage = data.path != null && File(data.path!).existsSync();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: showEditButton ? onEditTap : null,
              child: Container(
                width: size.w,
                height: size.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: hasImage
                      ? null
                      : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryColor.withValues(alpha: 0.85),
                      AppColors.primaryColor,
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.white4,
                    width: borderWidth,
                  ),
                ),
                child: ClipOval(
                  child: hasImage
                      ? Image.file(
                    File(data.path!),
                    key: ValueKey(data.version),
                    width: size.w,
                    height: size.h,
                    fit: BoxFit.cover,
                  )
                      : Center(
                    child: Text(
                      initials,
                      style: (size >= 80
                          ? AppTextStyles.font34Bold(context)
                          : AppTextStyles.font16Bold(context))
                          .copyWith(color: AppColors.background),
                    ),
                  ),
                ),
              ),
            ),
            if (showEditButton)
              Positioned(
                right: 4,
                bottom: 4,
                child: GestureDetector(
                  onTap: onEditTap,
                  child: Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: AppColors.background,
                      size: 18,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}