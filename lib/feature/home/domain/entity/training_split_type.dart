import 'package:fitness/feature/home/domain/entity/workout_category.dart';

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
