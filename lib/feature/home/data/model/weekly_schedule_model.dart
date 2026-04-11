import 'package:fitness/feature/home/data/model/exercise_model.dart';

enum TrainingSplitType {
  pushPullLegs,
  upperLower,
  fullBody,
  broSplit;

  String get displayName {
    switch (this) {
      case pushPullLegs: return 'Push/Pull/Legs Split';
      case upperLower:   return 'Upper/Lower Split';
      case fullBody:     return 'Full Body Split';
      case broSplit:     return 'Bro Split';
    }
  }

  List<WorkoutCategory> get categories {
    switch (this) {
      case pushPullLegs:
        return [
          WorkoutCategory.push,
          WorkoutCategory.pull,
          WorkoutCategory.legs,
          WorkoutCategory.rest,
        ];
      case upperLower:
        return [
          WorkoutCategory.upper,
          WorkoutCategory.lowerBody,
          WorkoutCategory.rest,
        ];
      case fullBody:
        return [
          WorkoutCategory.fullBody,
          WorkoutCategory.rest,
        ];
      case broSplit:
        return [
          WorkoutCategory.chest,
          WorkoutCategory.back,
          WorkoutCategory.shoulders,
          WorkoutCategory.legs,
          WorkoutCategory.arms,
          WorkoutCategory.rest,
        ];
    }
  }
}

enum WorkoutCategory {
  push('💪 Push'),
  pull('🔙 Pull'),
  legs('🦵 Legs'),
  upper('💪 Upper Body'),
  lowerBody('🦵 Lower Body'),
  fullBody('🏋️ Full Body'),
  chest('💪 Chest'),
  back('🔙 Back'),
  shoulders('🤷 Shoulders'),
  arms('💪 Arms'),
  rest('😴 Rest');

  const WorkoutCategory(this.label);
  final String label;
}

class DaySchedule {
  final String dayName;
  WorkoutCategory? category;
  List<ExerciseModel> exercises;
  final bool isToday;

  DaySchedule({
    required this.dayName,
    this.category,
    List<ExerciseModel>? exercises,
    this.isToday = false,
  }) : exercises = exercises ?? [];
}