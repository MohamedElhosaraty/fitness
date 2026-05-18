import 'package:hive/hive.dart';
import 'workout_day_model.dart';

part 'plan_model.g.dart';

@HiveType(typeId: 3)
class PlanModel extends HiveObject {
  @HiveField(0)
  final String planId;
  @HiveField(1)
  final String goalId;
  @HiveField(2)
  final int availabilityDays;
  @HiveField(3)
  List<WorkoutDayModel> workoutDays;

  PlanModel({
    required this.planId,
    required this.goalId,
    required this.availabilityDays,
    required this.workoutDays,
  });

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      planId: map['plan_id'] ?? '',
      goalId: map['goal_id'] ?? '',
      availabilityDays: map['availability_days'] ?? 0,
      workoutDays:
          (map['workout_days'] as List? ?? [])
              .map((d) => WorkoutDayModel.fromMap(Map<String, dynamic>.from(d)))
              .toList(),
    );
  }
}
