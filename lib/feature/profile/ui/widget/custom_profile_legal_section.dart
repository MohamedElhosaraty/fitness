import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/localization/localization_methods.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';
import 'custom_profile_settings_tile.dart';

class CustomProfileLegalSection extends StatefulWidget {
  const CustomProfileLegalSection({super.key});

  @override
  State<CustomProfileLegalSection> createState() => _CustomProfileLegalSectionState();
}

class _CustomProfileLegalSectionState extends State<CustomProfileLegalSection> {

  String _version = '';
  String _build = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (!mounted) return;
      setState(() {
        _version = info.version;
        _build = info.buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_version.isEmpty) return const SizedBox();
    final versionText = tr(context, AppStrings.appVersion)
        .replaceAll('{version}', _version)
        .replaceAll('{build}', _build);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.white4),
          ),
          child: Column(
            children: [
              CustomProfileSettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: tr(context, AppStrings.privacyPolicy),
                showExternalLink: true,
                onTap: () {},
              ),
              CustomProfileSettingsTile(
                icon: Icons.description_outlined,
                title: tr(context, AppStrings.termsOfService),
                showExternalLink: true,
                showDivider: false,
                onTap: () {},
              ),
            ],
          ),
        ),
        24.verticalSpace,
        Text(
          versionText,
          textAlign: TextAlign.center,
          style: AppTextStyles.font12Medium(context).copyWith(
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
