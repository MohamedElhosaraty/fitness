import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_profile_header.dart';
import 'custom_profile_legal_section.dart';
import 'custom_profile_settings_section.dart';
import 'custom_profile_stats_row.dart';
import 'custom_profile_top_bar.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          const CustomProfileTopBar(),
          24.verticalSpace,
          const CustomProfileHeader(),
          24.verticalSpace,
          const CustomProfileStatsRow(),
          28.verticalSpace,
          const CustomProfileSettingsSection(),
          20.verticalSpace,
          const CustomProfileLegalSection(),
          20.verticalSpace,
        ],
      ),
    );
  }
}
