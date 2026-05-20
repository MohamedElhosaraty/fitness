import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';
import '../../../../core/helpers/profile_helpers.dart';
import 'custom_profile_avatar.dart';
import 'custom_profile_image_picker_sheet.dart';

class CustomProfileHeader extends StatelessWidget {
  const CustomProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomProfileAvatar(
          size: 112,
          showEditButton: true,
          onEditTap: () => CustomProfileImagePickerSheet.show(context),
        ),
        16.verticalSpace,
        Text(
          profileUserName(context),
          style: AppTextStyles.font20Bold(context).copyWith(
            color: AppColors.black,
          ),
        ),
        6.verticalSpace,
        Text(
          tr(context, AppStrings.proMemberSince),
          style: AppTextStyles.font14Regular(context).copyWith(
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
