import 'package:fitness/feature/home/ui/widgets/custom_split_button.dart';
import 'package:fitness/feature/home/ui/widgets/custom_split_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';

class AllCustomSplitCard extends StatelessWidget {
  const AllCustomSplitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomSplitCard(
          title: "Push/Pull/Legs",
          subtitle: "Split workouts by movement patterns",
          buttons: [
            CustomSplitButton(
                text: "Push", color: AppColors.primaryColor, emoji: "💪"),
            CustomSplitButton(
                text: "Pull", color: AppColors.green, emoji: "🏋️"),
            CustomSplitButton(
                text: "Legs", color: AppColors.purple, emoji: "🦵"),
            CustomSplitButton(
                text: "Rest", color: AppColors.grey, emoji: "😴"),
          ],
        ),
        16.verticalSpace,
        const CustomSplitCard(
          title: "Upper/Lower",
          subtitle: "Split by body regions",
          buttons: [
            CustomSplitButton(text: "Upper Body", color: AppColors.primaryColor, emoji: "💪"),
            CustomSplitButton(text: "Lower Body", color: AppColors.purple, emoji: "🦵"),
            CustomSplitButton(text: "Rest", color: AppColors.grey, emoji: "😴"),
          ],
        ),
        16.verticalSpace,
        const CustomSplitCard(
          title: "Full Body",
          subtitle: "Train everything each session",
          buttons: [
            CustomSplitButton(
                text: "Full Body", color: AppColors.primaryColor, emoji: "🏋️"),
            CustomSplitButton(text: "Rest", color: AppColors.grey, emoji: "😴"),
          ],
        ),
        16.verticalSpace,
        const CustomSplitCard(
          title: "Bro Split",
          subtitle: "One muscle group per day",
          buttons: [
            CustomSplitButton(text: "Chest", color: AppColors.red, emoji: "💪"),
            CustomSplitButton(
                text: "Back", color: AppColors.green, emoji: "🏋️"),
            CustomSplitButton(text: "Legs", color: AppColors.purple, emoji: "🦵"),
            CustomSplitButton(text: "Shoulders", color: AppColors.yellow, emoji: "💪"),
            CustomSplitButton(text: "Arms", color: AppColors.orange, emoji: "💪"),
            CustomSplitButton(text: "Rest", color: AppColors.grey, emoji: "😴"),
          ],
        ),
      ],
    );
  }
}
