import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/cubit/localization_cubit.dart';
import '../../data/model/onboarding_goal_model.dart';
import 'custom_onboarding_goal_item.dart';

class CustomOnboardingGoalCard extends StatefulWidget {
  final List<OnboardingGoalModel> goals;

  const CustomOnboardingGoalCard({
    super.key,
    required this.goals,
  });

  @override
  State<CustomOnboardingGoalCard> createState() =>
      _CustomOnboardingGoalCardState();
}

class _CustomOnboardingGoalCardState extends State<CustomOnboardingGoalCard> {
  int _selectedGoal = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.goals.length,
      separatorBuilder: (_, __) => 12.verticalSpace,
      itemBuilder: (context, index) => CustomOnboardingGoalItem(
        goal: widget.goals[index],
        isSelected: _selectedGoal == index,
        onTap: () => setState(() => _selectedGoal = index),
        locale: context.watch<LocalizationCubit>().currentLocale.languageCode,
      ),
    );
  }
}