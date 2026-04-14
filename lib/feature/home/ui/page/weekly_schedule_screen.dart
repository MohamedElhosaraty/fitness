import 'package:fitness/feature/home/ui/widgets/custom_app_bar.dart';
import 'package:fitness/feature/home/ui/widgets/custom_header_schedule.dart';
import 'package:fitness/feature/home/ui/widgets/custom_sliver_list_day_card.dart';
import 'package:flutter/material.dart';
import '../../domain/entity/training_split_type.dart';

class WeeklyScheduleScreen extends StatelessWidget {
  const WeeklyScheduleScreen({super.key, required this.splitType});

  final TrainingSplitType splitType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: CustomAppBar(title: "Weekly Schedule"),
              ),
              SliverToBoxAdapter(
                child: CustomHeaderSchedule(
                  header: splitType.displayName,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              CustomSliverListDayCard(splitType: splitType),
            ],
          ),
        ),
      ),
    );
  }
}
