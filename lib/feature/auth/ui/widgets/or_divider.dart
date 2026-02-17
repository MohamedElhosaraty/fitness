import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(
              0xffDDDFDF,
            ),
          ),
        ),
        18.horizontalSpace,
        Text(
          "OR",
          style: AppTextStyles.font16Bold(context),
        ),
        18.horizontalSpace,
        Expanded(
          child: Divider(
            color: Color(
              0xffDDDFDF,
            ),
          ),
        ),
      ],
    );
  }
}