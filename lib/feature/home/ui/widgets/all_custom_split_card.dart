import 'package:fitness/core/helpers/extensions.dart';
import 'package:fitness/feature/home/ui/widgets/custom_split_button.dart';
import 'package:fitness/feature/home/ui/widgets/custom_split_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/model/weekly_schedule_model.dart';

class AllCustomSplitCard extends StatefulWidget {
  const AllCustomSplitCard({super.key});

  @override
  State<AllCustomSplitCard> createState() => _AllCustomSplitCardState();
}

class _AllCustomSplitCardState extends State<AllCustomSplitCard> {

  TrainingSplitType? selectedSplit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedSplit = TrainingSplitType.pushPullLegs;
            });
             context.pushNamed(Routes.weeklyScheduleScreen, arguments: TrainingSplitType.pushPullLegs);
          },
          child: CustomSplitCard(
            isSelected: selectedSplit == TrainingSplitType.pushPullLegs,
            title: "Push/Pull/Legs",
            subtitle: "Split workouts by movement patterns",
            buttons: const [
              CustomSplitButton(text: "Push", color: AppColors.primaryColor, emoji: "💪"),
              CustomSplitButton(text: "Pull", color: AppColors.green, emoji: "🏋️"),
              CustomSplitButton(text: "Legs", color: AppColors.purple, emoji: "🦵"),
              CustomSplitButton(text: "Rest", color: AppColors.grey, emoji: "😴"),
            ],
          ),
        ),
        16.verticalSpace,

        InkWell(
          onTap: () {
            setState(() {
              selectedSplit = TrainingSplitType.upperLower;
            });
            context.pushNamed(Routes.weeklyScheduleScreen, arguments: TrainingSplitType.upperLower);
          },
          child: CustomSplitCard(
            isSelected: selectedSplit == TrainingSplitType.upperLower,
            title: "Upper/Lower",
            subtitle: "Split by body regions",
            buttons: const [
              CustomSplitButton(text: "Upper Body", color: AppColors.primaryColor, emoji: "💪"),
              CustomSplitButton(text: "Lower Body", color: AppColors.purple, emoji: "🦵"),
              CustomSplitButton(text: "Rest", color: AppColors.grey, emoji: "😴"),
            ],
          ),
        ),
        16.verticalSpace,

        InkWell(
          onTap: () {
            setState(() {
              selectedSplit = TrainingSplitType.fullBody;
            });
            context.pushNamed(Routes.weeklyScheduleScreen, arguments: TrainingSplitType.fullBody);
          },
          child: CustomSplitCard(
            isSelected: selectedSplit == TrainingSplitType.fullBody,
            title: "Full Body",
            subtitle: "Train everything each session",
            buttons: const [
              CustomSplitButton(text: "Full Body", color: AppColors.primaryColor, emoji: "🏋️"),
              CustomSplitButton(text: "Rest", color: AppColors.grey, emoji: "😴"),
            ],
          ),
        ),
        16.verticalSpace,

        InkWell(
          onTap: () {
            setState(() {
              selectedSplit = TrainingSplitType.broSplit;
            });
            context.pushNamed(Routes.weeklyScheduleScreen, arguments: TrainingSplitType.broSplit);
          },
          child: CustomSplitCard(
            isSelected: selectedSplit == TrainingSplitType.broSplit,
            title: "Bro Split",
            subtitle: "One muscle group per day",
            buttons: const [
              CustomSplitButton(text: "Chest", color: AppColors.red, emoji: "💪"),
              CustomSplitButton(text: "Back", color: AppColors.green, emoji: "🏋️"),
              CustomSplitButton(text: "Legs", color: AppColors.purple, emoji: "🦵"),
              CustomSplitButton(text: "Shoulders", color: AppColors.yellow, emoji: "💪"),
              CustomSplitButton(text: "Arms", color: AppColors.orange, emoji: "💪"),
              CustomSplitButton(text: "Rest", color: AppColors.grey, emoji: "😴"),
            ],
          ),
        ),
      ],
    );
  }
}
