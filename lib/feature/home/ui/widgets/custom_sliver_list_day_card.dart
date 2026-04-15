import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/get_today_name.dart';
import '../../data/model/day_schedule_model.dart';
import '../../domain/entity/training_split_type.dart';
import '../cubit/get_day_exercises/get_day_exercises_cubit.dart';
import 'custom_day_card.dart';

class CustomSliverListDayCard extends StatefulWidget {
  const CustomSliverListDayCard({super.key, required this.splitType});

  final TrainingSplitType splitType;

  @override
  State<CustomSliverListDayCard> createState() =>
      _CustomSliverListDayCardState();
}

class _CustomSliverListDayCardState extends State<CustomSliverListDayCard> {

  late final List<GetDayExercisesCubit> _cubits;

  @override
  void initState() {
    super.initState();
    // create 7 cubits for 7 days
    _cubits = List.generate(
      7,
          (i) => getIt<GetDayExercisesCubit>()
        ..watchDayExercises(dayName: GetTodayName.weekDayNames[i]),
    );
  }

  @override
  void dispose() {
    for (final cubit in _cubits) {
      cubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int todayIndex = GetTodayName.todayIndex;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BlocProvider.value(
            value: _cubits[index],
            child: CustomDayCard(
              day: DayScheduleModel(
                dayName: GetTodayName.weekDayNames[index],
                isToday: index == todayIndex,
              ),
              availableCategories: widget.splitType.categories,
              splitType: widget.splitType,
            ),
          ),
        ),
        childCount: GetTodayName.weekDayNames.length,
      ),
    );
  }
}