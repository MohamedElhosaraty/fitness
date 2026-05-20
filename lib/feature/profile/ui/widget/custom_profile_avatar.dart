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

    return ValueListenableBuilder<String?>(
      valueListenable: ProfileImageStorage.imagePathNotifier,
      builder: (context, imagePath, _) {
        return ValueListenableBuilder<int>(
          valueListenable: ProfileImageStorage.imageGeneration,
          builder: (context, generation, _) {
            final hasImage =
                imagePath != null && File(imagePath).existsSync();

            return Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: showEditButton ? onEditTap : null,
                  child: Container(
                    width: size.w,
                    height: size.w,
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
                              File(imagePath),
                              key: ValueKey('avatar-$generation'),
                              width: size.w,
                              height: size.w,
                              fit: BoxFit.cover,
                              gaplessPlayback: false,
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
                          Icons.edit_outlined,
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
      },
    );
  }
}
