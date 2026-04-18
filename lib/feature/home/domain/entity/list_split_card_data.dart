import 'package:fitness/feature/home/domain/entity/split_card_data.dart';
import 'package:fitness/feature/home/domain/entity/training_split_type.dart';

import '../../../../core/theming/app_colors.dart';
import '../../ui/widgets/custom_split_button.dart';

const List<SplitCardData> listSplitCardData  = [
  SplitCardData(
    type: TrainingSplitType.pushPullLegs,
    title: "Push/Pull/Legs",
    subtitle: "Split workouts by movement patterns",
    buttons: [
      CustomSplitButton(text: "Push", color: AppColors.primaryColor, emoji: "💪"),
      CustomSplitButton(text: "Pull", color: AppColors.green,        emoji: "🏋️"),
      CustomSplitButton(text: "Legs", color: AppColors.purple,       emoji: "🦵"),
      CustomSplitButton(text: "Rest", color: AppColors.grey,         emoji: "😴"),
    ],
  ),
  SplitCardData(
    type: TrainingSplitType.upperLower,
    title: "Upper/Lower",
    subtitle: "Split by body regions",
    buttons: [
      CustomSplitButton(text: "Upper Body", color: AppColors.primaryColor, emoji: "💪"),
      CustomSplitButton(text: "Lower Body", color: AppColors.purple,       emoji: "🦵"),
      CustomSplitButton(text: "Rest",       color: AppColors.grey,         emoji: "😴"),
    ],
  ),
  SplitCardData(
    type: TrainingSplitType.fullBody,
    title: "Full Body",
    subtitle: "Train everything each session",
    buttons: [
      CustomSplitButton(text: "Full Body", color: AppColors.primaryColor, emoji: "🏋️"),
      CustomSplitButton(text: "Rest",      color: AppColors.grey,         emoji: "😴"),
    ],
  ),
  SplitCardData(
    type: TrainingSplitType.broSplit,
    title: "Bro Split",
    subtitle: "One muscle group per day",
    buttons: [
      CustomSplitButton(text: "Chest",     color: AppColors.red,    emoji: "💪"),
      CustomSplitButton(text: "Back",      color: AppColors.green,  emoji: "🏋️"),
      CustomSplitButton(text: "Legs",      color: AppColors.purple, emoji: "🦵"),
      CustomSplitButton(text: "Shoulders", color: AppColors.yellow, emoji: "💪"),
      CustomSplitButton(text: "Arms",      color: AppColors.orange, emoji: "💪"),
      CustomSplitButton(text: "Rest",      color: AppColors.grey,   emoji: "😴"),
    ],
  ),
];