import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';

class CustomSelectImage extends StatelessWidget {
  const CustomSelectImage({super.key,required this.profileImage});

  final File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
        image: profileImage != null
            ? DecorationImage(
          image: FileImage(profileImage!),
          fit: BoxFit.contain,
        )
            : null,
      ),
      child: profileImage == null
          ? const Icon(Icons.camera_alt, size: 60, color: Colors.white)
          : null,
    );
  }
}
