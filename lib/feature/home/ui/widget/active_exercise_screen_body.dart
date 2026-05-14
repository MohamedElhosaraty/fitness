import 'package:fitness/core/helpers/extensions.dart';
import 'package:fitness/feature/home/ui/cubit/workout_cubit/workout_cubit.dart';
import 'package:fitness/feature/home/ui/widget/custom_active_exercise_header.dart';
import 'package:fitness/feature/home/ui/widget/custom_form_cues.dart';
import 'package:fitness/feature/home/ui/widget/custom_sets_section.dart';
import 'package:fitness/feature/home/ui/widget/custom_timer_bar.dart';
import 'package:fitness/feature/home/ui/widget/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../onboarding/data/model/workout_exercise_model.dart';

class ActiveExerciseScreenBody extends StatefulWidget {
  const ActiveExerciseScreenBody({super.key, required this.dayExercise});

  final List<WorkoutExerciseModel> dayExercise;

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
                CustomVideoPlayer(
                  videoId: widget.dayExercise[_currentIndex].videoUrl,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Text(
                    widget.dayExercise[_currentIndex].getTitle(context.currentLang),
                    style: AppTextStyles.font17Medium(context).copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                CustomFormCues(
                  cues: widget.dayExercise[_currentIndex].getFormCues(context.currentLang),
                ),
                CustomSetsSection(
                  key: ValueKey(_currentIndex),
                  exercise: widget.dayExercise[_currentIndex],
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
        CustomTimerBar(
          timerSeconds: widget.dayExercise[_currentIndex].restSeconds,
        ),
      ],
    );
  }
}
