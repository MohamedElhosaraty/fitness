import 'package:hive/hive.dart';
import 'workout_exercise_model.dart';

part 'workout_day_model.g.dart';

@HiveType(typeId: 2)
class WorkoutDayModel extends HiveObject {
  @HiveField(0)
  final int dayNumber;

  @HiveField(1)
  final String workoutTitleEn;

  @HiveField(2)
  final String workoutTitleAr;

  @HiveField(3)
  final List<WorkoutExerciseModel> workoutExercises;

  WorkoutDayModel({
    required this.dayNumber,
    required this.workoutTitleEn,
    required this.workoutTitleAr,
    required this.workoutExercises,
  });

  // fromMap ده بس للـ structure بدون تفاصيل التمارين
  // التفاصيل بتتجيب من getDayExercises عن طريق fromMerged
  factory WorkoutDayModel.fromMap(Map<String, dynamic> map) {
    final title = Map<String, dynamic>.from(map['workout_title'] ?? {});

    return WorkoutDayModel(
      dayNumber: map['day_number'] ?? 0,
      workoutTitleEn: title['en'] ?? '',
      workoutTitleAr: title['ar'] ?? '',
      workoutExercises: const [], // بتتملى بعدين في الـ repository
    );
  }

  // Factory لما بيكون عندنا التمارين كاملة
  factory WorkoutDayModel.withExercises({
    required Map<String, dynamic> map,
    required List<WorkoutExerciseModel> exercises,
  }) {
    final title = Map<String, dynamic>.from(map['workout_title'] ?? {});

    return WorkoutDayModel(
      dayNumber: map['day_number'] ?? 0,
      workoutTitleEn: title['en'] ?? '',
      workoutTitleAr: title['ar'] ?? '',
      workoutExercises: exercises,
    );
  }

  String getTitle(String lang) =>
      lang == 'ar' ? workoutTitleAr : workoutTitleEn;

}