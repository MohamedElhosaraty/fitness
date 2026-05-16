import 'package:fitness/feature/home/data/model/workout_set.dart';
import 'package:fitness/feature/home/ui/widget/custom_add_set_button.dart';
import 'package:fitness/feature/home/ui/widget/custom_set_row.dart';
import 'package:fitness/feature/home/ui/widget/custom_sets_header.dart';
import 'package:fitness/feature/home/ui/widget/weight_input_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../onboarding/data/model/workout_exercise_model.dart';

class CustomSetsSection extends StatefulWidget {
  const CustomSetsSection({super.key, required this.exercise});

  final WorkoutExerciseModel exercise;

  @override
  State<CustomSetsSection> createState() => _CustomSetsSectionState();
}

class _CustomSetsSectionState extends State<CustomSetsSection> {
  static const double _defaultWeight = 25.0;

  late List<WorkoutSet> _sets;

  @override
  void initState() {
    super.initState();
    _initSets(_defaultWeight);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWeightDialog();
    });
  }

  void _initSets(double weight) {
    final setsCount = int.tryParse(widget.exercise.sets) ?? 3;
    final repsMin = int.tryParse(widget.exercise.reps) ?? 12;
    _sets = List.generate(
      setsCount,
      (index) => WorkoutSet(
        weight: weight,
        reps: repsMin,
        isDone: false,
        isActive: index == 0,
      ),
    );
  }

  void _showWeightDialog() async {
    final result = await showDialog<double>(
      context: context,
      builder: (context) => const WeightInputDialog(),
    );

    setState(() {
      _initSets(result ?? _defaultWeight);
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
  }

  void _addSet() {
    setState(() {
      final allDone = _sets.every((s) => s.isDone);
      if (!allDone) return;

      final lastWeight = _sets.isNotEmpty ? _sets.last.weight : _defaultWeight;

      _sets.add(
        WorkoutSet(
          weight: lastWeight,
          reps: int.tryParse(widget.exercise.reps) ?? 12,
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
              onWeightChanged: (index, newWeight) {
                setState(() {
                  _sets[index] = _sets[index].copyWith(weight: newWeight);
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
