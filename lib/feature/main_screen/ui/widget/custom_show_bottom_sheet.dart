import 'package:fitness/core/helpers/shared_prefs_keys.dart';
import 'package:fitness/core/helpers/shared_pref_helper.dart';
import 'package:fitness/core/localization/localization_methods.dart';
import 'package:fitness/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/app_strings.dart';

class CustomShowBottomSheet extends StatelessWidget {
  CustomShowBottomSheet({super.key});

  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _onSave(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    await SharedPrefHelper.setString(
      SharedPrefsKeys.name,
      _nameController.text.trim(),
    );

    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(context, AppStrings.userName),
              style: AppTextStyles.font19Bold(context),
            ),
            16.verticalSpace,
            CustomTextField(
              textController: _nameController,
              textInputAction: TextInputAction.done,
              onSaved: (_) => _onSave(context),
              labelText: tr(context, AppStrings.userName),
              hintText: tr(context, AppStrings.pleaseEnterName),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return tr(context, AppStrings.pleaseEnterName);
                }
                return null;
              },
            ),
            16.verticalSpace,
            CustomButton(
              yPadding: 15,
              borderRadius: 10,
              onPressed: () => _onSave(context),
              child: Text(
                tr(context, AppStrings.save),
                style: AppTextStyles.font16Bold(
                  context,
                ).copyWith(color: AppColors.background),
              ),
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}
