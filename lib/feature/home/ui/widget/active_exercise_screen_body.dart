import 'package:fitness/core/helpers/extensions.dart';
import 'package:fitness/feature/home/ui/cubit/workout_cubit/workout_cubit.dart';
import 'package:fitness/feature/home/ui/widget/custom_active_exercise_header.dart';
import 'package:fitness/feature/home/ui/widget/custom_form_cues.dart';
import 'package:fitness/feature/home/ui/widget/custom_sets_section.dart';
import 'package:fitness/feature/home/ui/widget/custom_timer_bar.dart';
import 'package:fitness/feature/home/ui/widget/custom_video_player.dart';
import 'package:fitness/feature/onboarding/data/model/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';

class ActiveExerciseScreenBody extends StatefulWidget {
  const ActiveExerciseScreenBody({super.key, required this.dayExercise});

  final List<ExerciseModel> dayExercise;

  @override
  State<ActiveExerciseScreenBody> createState() => _ActiveExerciseScreenBodyState();
}

class _ActiveExerciseScreenBodyState extends State<ActiveExerciseScreenBody> {

  int _currentIndex = 0;

  void _next() {
    if (_currentIndex < widget.dayExercise.length - 1) {
      setState(() => _currentIndex++);
    } else {
      context.read<WorkoutCubit>().completeDay();
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomActiveExerciseHeader(
          onNext: _next,
          isLast:  _currentIndex == widget.dayExercise.length - 1,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomVideoPlayer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Text(
                    widget.dayExercise[_currentIndex].getTitle(context.currentLang),
                    style: AppTextStyles.font17Medium(context).copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                const CustomFormCues(),
                CustomSetsSection(
                  key: ValueKey(_currentIndex),
                  exercise: widget.dayExercise[_currentIndex],
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
        const CustomTimerBar(),
      ],
    );
  }
}
