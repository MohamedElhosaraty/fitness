import 'package:fitness/core/helpers/extensions.dart';
import 'package:fitness/feature/home/ui/widget/custom_active_exercise_header.dart';
import 'package:fitness/feature/home/ui/widget/custom_form_cues.dart';
import 'package:fitness/feature/home/ui/widget/custom_sets_section.dart';
import 'package:fitness/feature/home/ui/widget/custom_timer_bar.dart';
import 'package:fitness/feature/home/ui/widget/custom_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_boxes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../../onboarding/data/model/workout_exercise_model.dart';

class ActiveExerciseScreenBody extends StatefulWidget {
  const ActiveExerciseScreenBody({
    super.key,
    required this.dayExercise,
    required this.currentSlot,
  });

  final List<WorkoutExerciseModel> dayExercise;
  final int? currentSlot;

  @override
  State<ActiveExerciseScreenBody> createState() =>
      _ActiveExerciseScreenBodyState();
}

class _ActiveExerciseScreenBodyState extends State<ActiveExerciseScreenBody> {
  late final PageController _pageController;
  int _currentIndex = 0;
  Future<void> Function()? _startTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() async {
    if (_currentIndex < widget.dayExercise.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      final slot = widget.currentSlot;
      if (slot != null) {
        final finished = AppBoxes.finishedSlots;
        if (!finished.contains(slot)) {
          await AppBoxes.setFinishedSlots([...finished, slot]);
        }
      }
      if (!mounted) return;
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomActiveExerciseHeader(
          onNext: _next,
          isLast: _currentIndex == widget.dayExercise.length - 1,
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.dayExercise.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final exercise = widget.dayExercise[index];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomVideoPlayer(videoId: exercise.videoUrl),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
                      child: Text(
                        exercise.getTitle(context.currentLang),
                        style: AppTextStyles.font17Medium(
                          context,
                        ).copyWith(color: AppColors.black),
                      ),
                    ),
                    CustomFormCues(
                      cues: exercise.getFormCues(context.currentLang),
                    ),
                    CustomSetsSection(
                      exercise: exercise,
                      onSetDone: () => _startTimer?.call(),
                    ),
                    20.verticalSpace,
                  ],
                ),
              );
            },
          ),
        ),
        CustomTimerBar(
          timerSeconds: widget.dayExercise[_currentIndex].restSeconds,
          onStartTimer: (fn) => _startTimer = fn,
        ),
      ],
    );
  }
}
