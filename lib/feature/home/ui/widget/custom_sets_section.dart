import 'package:fitness/feature/home/data/model/workout_set.dart';
import 'package:fitness/feature/home/ui/widget/custom_add_set_button.dart';
import 'package:fitness/feature/home/ui/widget/custom_set_row.dart';
import 'package:fitness/feature/home/ui/widget/custom_sets_header.dart';
import 'package:fitness/feature/home/ui/widget/weight_input_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/hive_helper.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../onboarding/data/model/workout_exercise_model.dart';
import '../../../onboarding/data/model/workout_set_model.dart';

class CustomSetsSection extends StatefulWidget {
  const CustomSetsSection({
    super.key,
    required this.exercise,
    this.onSetDone,
    this.onRegisterToggleDone,
    this.isTimerRunning,
    this.onRegisterIsAllDone,
  });

  final WorkoutExerciseModel exercise;
  final VoidCallback? onSetDone;
  final void Function(VoidCallback fn)? onRegisterToggleDone;
  final bool Function()? isTimerRunning;
  final void Function(bool Function() fn)? onRegisterIsAllDone;

  @override
  State<CustomSetsSection> createState() => _CustomSetsSectionState();
}

class _CustomSetsSectionState extends State<CustomSetsSection> {
  late List<WorkoutSet> _sets;

  @override
  void initState() {
    super.initState();
    _initSets();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onRegisterToggleDone?.call(_toggleNextActiveDone);
      widget.onRegisterIsAllDone?.call(() => _sets.every((s) => s.isDone));
      if (_sets.every((s) => !s.isDone)) {
        _showWeightDialog();
      }
    });
  }

  void _initSets() {
    _sets = List.generate(widget.exercise.sets.length, (i) {
      final savedSet = widget.exercise.sets[i];
      return WorkoutSet(
        weight: savedSet.weight,
        reps: savedSet.reps,
        isDone: savedSet.isDone,
        isActive: false,
      );
    });

    final firstNotDoneIndex = _sets.indexWhere((s) => !s.isDone);
    if (firstNotDoneIndex != -1) {
      _sets[firstNotDoneIndex] = _sets[firstNotDoneIndex].copyWith(
        isActive: true,
      );
    }
  }

  void _showWeightDialog() async {
    final result = await showDialog<double>(
      context: context,
      builder:
          (context) => WeightInputDialog(
        initialWeight: _sets.isNotEmpty ? _sets[0].weight : 25.0,
      ),
    );

    if (result == null) return;

    await HiveHelper.updateSet(
      exerciseId: widget.exercise.exerciseId,
      setIndex: 0,
      newWeight: result,
    );
    setState(() {
      _sets[0] = _sets[0].copyWith(weight: result);
    });
  }

  void _toggleDone(int index) {
    if (widget.isTimerRunning?.call() == true) return;
    if (!_sets[index].isActive) return;

    setState(() {
      _sets[index] = _sets[index].copyWith(isDone: true, isActive: false);

      if (index + 1 < _sets.length) {
        _sets[index + 1] = _sets[index + 1].copyWith(isActive: true);
      }

      widget.onSetDone?.call();
    });

    HiveHelper.updateSet(
      exerciseId: widget.exercise.exerciseId,
      setIndex: index,
      newDone: true,
    );
  }

  void _toggleUndone(int index) {
    if (widget.isTimerRunning?.call() == true) return;
    if (!_sets[index].isDone) return;
    final isLastDone = _sets.sublist(index + 1).every((s) => !s.isDone);
    if (!isLastDone) return;

    setState(() {
      _sets[index] = _sets[index].copyWith(isDone: false, isActive: true);

      if (index + 1 < _sets.length && _sets[index + 1].isActive) {
        _sets[index + 1] = _sets[index + 1].copyWith(isActive: false);
      }
    });

    HiveHelper.updateSet(
      exerciseId: widget.exercise.exerciseId,
      setIndex: index,
      newDone: false,
    );
  }

  void _toggleNextActiveDone() {
    final index = _sets.indexWhere((s) => s.isActive);
    if (index != -1) {
      _toggleDone(index);
    }
  }

  void _addSet() async {
    final allDone = _sets.every((s) => s.isDone);
    if (!allDone) return;

    final newSet = WorkoutSetModel(
      setNumber: _sets.length + 1,
      weight: widget.exercise.sets.last.weight,
      reps: widget.exercise.sets.last.reps,
    );

    await HiveHelper.addSet(
      exerciseId: widget.exercise.exerciseId,
      newSet: newSet,
    );

    setState(() {
      for (var i = 0; i < _sets.length; i++) {
        _sets[i] = _sets[i].copyWith(isActive: false);
      }
      _sets.add(
        WorkoutSet(
          weight: newSet.weight,
          reps: newSet.reps,
          isDone: false,
          isActive: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.white4),
      ),
      child: Column(
        children: [
          const CustomSetsHeader(),
          ...List.generate(
            _sets.length,
                (i) => CustomSetRow(
              index: i,
              sets: _sets,
              toggleDone: _toggleDone,
              toggleUndone: _toggleUndone,
              exerciseId: widget.exercise.exerciseId,
              onWeightChanged: (index, newWeight) {
                setState(() {
                  _sets[index] = _sets[index].copyWith(weight: newWeight);
                });
              },
              onRepsChanged: (int index, int reps) {
                setState(() {
                  _sets[index] = _sets[index].copyWith(reps: reps);
                });
              },
            ),
          ),
          CustomAddSetButton(addSet: _addSet),
        ],
      ),
    );
  }
}