import 'package:flutter/material.dart';

import '../../data/model/weekly_schedule_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CustomDayCard(
            day: _days[index],
            availableCategories: widget.splitType.categories,
          ),
        ),
        childCount: _days.length,
      ),
    );
  }
}
