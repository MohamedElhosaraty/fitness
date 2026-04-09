import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class CustomHeaderSchedule extends StatelessWidget {
  const CustomHeaderSchedule({super.key, required this.header});

  final String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.5),),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                header,
                style: AppTextStyles.font19Bold(context).copyWith(
                  color: AppColors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Change',
                  style: AppTextStyles.font17Medium(context)
                      .copyWith(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          Text(overflow:  TextOverflow.ellipsis,
            'Assign categories to each day and add exercises',
            style: AppTextStyles.font14Regular(context).copyWith(
              color: AppColors.darkGrey,

            ),
          ),
        ],
      ),
    );
  }
}
