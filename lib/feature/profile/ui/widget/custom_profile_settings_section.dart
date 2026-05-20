import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/hive_helper.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../home/ui/cubit/workout_cubit/workout_cubit.dart';
import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../generated/app_strings.dart';
import 'custom_profile_language_sheet.dart';
import 'custom_profile_settings_tile.dart';

class CustomProfileSettingsSection extends StatelessWidget {
  const CustomProfileSettingsSection({super.key});

  Future<bool?> _confirm(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: AppTextStyles.font16Bold(ctx).copyWith(color: AppColors.black),
        ),
        content: Text(
          message,
          style: AppTextStyles.font14Regular(ctx).copyWith(
            color: AppColors.moreGrey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(tr(ctx, AppStrings.cancel)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              confirmLabel,
              style: TextStyle(
                color: isDestructive ? AppColors.red : AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _resetPlan(BuildContext context) async {
    final confirmed = await _confirm(
      context,
      title: tr(context, AppStrings.resetWorkoutPlanTitle),
      message: tr(context, AppStrings.resetWorkoutPlanMessage),
      confirmLabel: tr(context, AppStrings.reset),
    );
    if (confirmed != true || !context.mounted) return;

    await _clearWorkoutAndNavigateToOnboarding(context);
  }

  Future<void> _clearWorkoutAndNavigateToOnboarding(BuildContext context) async {
    await HiveHelper.resetWorkoutData();
    if (!context.mounted) return;
    context.read<WorkoutCubit>().reset();
    SharedPrefHelper.clear();
    context.pushNamedAndRemoveUntil(
      Routes.onboardingScreen,
      predicate: (_) => false,
    );
  }

  Future<void> _logOut(BuildContext context) async {
    final confirmed = await _confirm(
      context,
      title: tr(context, AppStrings.logOutTitle),
      message: tr(context, AppStrings.logOutMessage),
      confirmLabel: tr(context, AppStrings.logOut),
    );
    if (confirmed != true || !context.mounted) return;

    await _clearWorkoutAndNavigateToOnboarding(context);
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final confirmed = await _confirm(
      context,
      title: tr(context, AppStrings.deleteAccountTitle),
      message: tr(context, AppStrings.deleteAccountMessage),
      confirmLabel: tr(context, AppStrings.delete),
      isDestructive: true,
    );
    if (confirmed != true || !context.mounted) return;

    await _clearWorkoutAndNavigateToOnboarding(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        final isEnglish = (state as ChangeLanguageSuccess).language.languageCode == 'en';
        final languageLabel = isEnglish
            ? tr(context, AppStrings.englishUS)
            : tr(context, AppStrings.arabicEG);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(context, AppStrings.preferencesAndAccount),
              style: AppTextStyles.font10Bold(context).copyWith(
                color: AppColors.grey,
                letterSpacing: 0.8,
              ),
            ),
            12.verticalSpace,
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.white4),
              ),
              child: Column(
                children: [
                  CustomProfileSettingsTile(
                    icon: Icons.language_rounded,
                    iconBgColor: AppColors.blueSecondary.withValues(alpha: 0.35),
                    iconColor: AppColors.primaryColor,
                    title: tr(context, AppStrings.language),
                    trailingText: languageLabel,
                    onTap: () => CustomProfileLanguageSheet.show(context),
                  ),
                  CustomProfileSettingsTile(
                    icon: Icons.refresh_rounded,
                    title: tr(context, AppStrings.resetWorkoutPlan),
                    onTap: () => _resetPlan(context),
                  ),
                  CustomProfileSettingsTile(
                    icon: Icons.logout_rounded,
                    title: tr(context, AppStrings.logOut),
                    onTap: () => _logOut(context),
                  ),
                  CustomProfileSettingsTile(
                    icon: Icons.delete_outline_rounded,
                    iconBgColor: AppColors.red.withValues(alpha: 0.10),
                    iconColor: AppColors.red,
                    title: tr(context, AppStrings.deleteAccount),
                    titleColor: AppColors.red,
                    trailingColor: AppColors.red,
                    onTap: () => _deleteAccount(context),
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
