import 'package:fitness/feature/profile/ui/widget/custom_option_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helpers/profile_image_storage.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';

class CustomProfileImagePickerSheet extends StatelessWidget {
  const CustomProfileImagePickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const CustomProfileImagePickerSheet(),
    );
  }

  Future<void> _pick(BuildContext context, ImageSource source) async {
    Navigator.pop(context);

    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (picked == null) return;
      await ProfileImageStorage.savePickedImage(picked);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr(context, AppStrings.profileImagePickFailed)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(context, AppStrings.changeProfilePhoto),
            style: AppTextStyles.font19Bold(context).copyWith(
              color: AppColors.black,
            ),
          ),
          16.verticalSpace,
          CustomOptionImage(
            icon: Icons.photo_library_outlined,
            label: tr(context, AppStrings.chooseFromGallery),
            onTap: () => _pick(context, ImageSource.gallery),
          ),
          8.verticalSpace,
          CustomOptionImage(
            icon: Icons.photo_camera_outlined,
            label: tr(context, AppStrings.takePhoto),
            onTap: () => _pick(context, ImageSource.camera),
          ),
        ],
      ),
    );
  }
}