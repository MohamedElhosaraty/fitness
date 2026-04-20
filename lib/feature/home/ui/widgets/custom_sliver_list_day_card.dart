import 'package:flutter/material.dart';
import '../../../../core/helpers/get_today_name.dart';
import '../../data/model/day_schedule_model.dart';
import '../../domain/entity/training_split_type.dart';
import 'custom_day_card.dart';

class CustomSliverListDayCard extends StatelessWidget {
  const CustomSliverListDayCard({super.key, required this.splitType});

  final TrainingSplitType splitType;


  @override
  Widget build(BuildContext context) {
    final int todayIndex = GetTodayName.todayIndex;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CustomDayCard(
            day: DayScheduleModel(
              dayName: GetTodayName.weekDayNames[index],
              isToday: index == todayIndex,
            ),
            availableCategories: splitType.categories,
            splitType: splitType,
          ),
        ),
        childCount: GetTodayName.weekDayNames.length,
      ),
    );
  }
}