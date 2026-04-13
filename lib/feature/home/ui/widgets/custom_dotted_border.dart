import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomDottedBorder extends StatelessWidget {
  const CustomDottedBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         context.pushNamed(Routes.chooseTrainingSplitView);
      },
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [10, 5],
          strokeWidth: 2,
          radius: Radius.circular(16),
          color: Colors.indigo,
          padding: EdgeInsets.all(16),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 36.sp, color: AppColors.moreGrey),
              12.verticalSpace,
              Text("No workout scheduled",
                  style: AppTextStyles.font16Bold(context)
                      .copyWith(color: AppColors.moreGrey)),
              6.verticalSpace,
              Text("Tap to set up your weekly schedule",
                  style: AppTextStyles.font14Regular(context)
                      .copyWith(color: AppColors.moreGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
