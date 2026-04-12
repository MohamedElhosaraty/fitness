import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../data/model/weekly_schedule_model.dart';
import '../cubit/get_day_exercises/get_day_exercises_cubit.dart';
import 'custom_day_card.dart';

class CustomSliverListDayCard extends StatefulWidget {
  const CustomSliverListDayCard({super.key, required this.splitType});

  final TrainingSplitType splitType;


  @override
  State<CustomSliverListDayCard> createState() => _CustomSliverListDayCardState();
}

class _CustomSliverListDayCardState extends State<CustomSliverListDayCard> {

  final int _todayIndex = DateTime.now().weekday - 1;

  final List<String> _dayNames = [
    'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];

  late final List<DaySchedule> _days = List.generate(
    7,
        (i) => DaySchedule(
      dayName: _dayNames[i],
      isToday: i == _todayIndex,
    ),
  );

  // احفظ الـ cubits من أول عشان متتعملش من جديد عند كل scroll
  late final List<GetDayExercisesCubit> _cubits = List.generate(
    7,
        (i) => getIt<GetDayExercisesCubit>()..getDayExercises(dayName: _dayNames[i]),
  );

  @override
  void dispose() {
    for (final cubit in _cubits) {
      cubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BlocProvider.value(
            value: _cubits[index], // بدل create
            child: CustomDayCard(
              day: _days[index],
              availableCategories: widget.splitType.categories,
              splitType: widget.splitType,
            ),
          ),
        ),
        childCount: _days.length,
      ),
    );
  }
}
