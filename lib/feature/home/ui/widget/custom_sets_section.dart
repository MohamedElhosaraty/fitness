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
  const CustomSetsSection({super.key, required this.exercise , this.onSetDone});

  final WorkoutExerciseModel exercise;
  final VoidCallback? onSetDone;

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
      _showWeightDialog();
    });
  }

  void _initSets() {
    _sets = List.generate(
      widget.exercise.sets.length,
          (i) => WorkoutSet(
        weight  : widget.exercise.sets[i].weight,
        reps    : widget.exercise.sets[i].reps ,
        isDone  : false,
        isActive: i == 0,
      ),
    );
  }

  void _showWeightDialog() async {
    final result = await showDialog<double>(
      context: context,
      builder: (context) => WeightInputDialog(
        initialWeight: _sets.isNotEmpty ? _sets[0].weight : 25.0,
      ),
    );

    if (result == null) return;

    await HiveHelper.updateSet(
      exerciseId : widget.exercise.exerciseId,
      setIndex   : 0,
      newWeight  : result,
    );
    setState(() {
      _sets[0] = _sets[0].copyWith(weight: result);
    });
  }

  void _toggleDone(int index) {
    setState(() {
      if (!_sets[index].isActive) return;

      _sets[index] = _sets[index].copyWith(isDone: true, isActive: false);

      if (index + 1 < _sets.length) {
        _sets[index + 1] = _sets[index + 1].copyWith(isActive: true);
      }
    });
    widget.onSetDone?.call();
  }

  void _addSet() async {
    final allDone = _sets.every((s) => s.isDone);
    if (!allDone) return;

    final newSet = WorkoutSetModel(
      setNumber : _sets.length + 1,
      weight    : widget.exercise.sets.last.weight,
      reps      : widget.exercise.sets.last.reps,
    );

    await HiveHelper.addSet(
      exerciseId : widget.exercise.exerciseId,
      newSet     : newSet,
    );

    setState(() {
      _sets.add(WorkoutSet(
        weight  : newSet.weight,
        reps    : newSet.reps,
        isDone  : false,
        isActive: true,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color        : AppColors.background,
        borderRadius : BorderRadius.circular(14),
        border       : Border.all(color: AppColors.white4),
      ),
      child: Column(
        children: [
          const CustomSetsHeader(),
          ...List.generate(
            _sets.length,
                (i) => CustomSetRow(
              index          : i,
              sets           : _sets,
              toggleDone     : _toggleDone,
              exerciseId     : widget.exercise.exerciseId,
              onWeightChanged: (index, newWeight) {
                setState(() {
                  _sets[index] = _sets[index].copyWith(weight: newWeight);
                });
              }, onRepsChanged: (int index, int reps) {
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