import 'package:fitness/feature/home/ui/widgets/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: StatsCard(title: "This week", value: "145m")),
        12.horizontalSpace,
        const Expanded(
          child: StatsCard(title: "Streak", value: "5 days 🔥", isDay: true),
        ),
        12.horizontalSpace,
        const Expanded(child: StatsCard(title: "Workouts", value: "24")),
      ],
    );
  }
}
