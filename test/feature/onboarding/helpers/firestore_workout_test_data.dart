import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/feature/onboarding/data/model/workout_exercise_model.dart';

const String tPlanId = 'buildMuscle_2day';

final Map<String, dynamic> tPlanData = {
  'plan_id'          : 'buildMuscle_2day',
  'goal_id'          : 'buildMuscle',
  'availability_days': 2,
  'workout_days'     : [
    {
      'day_number'   : 1,
      'workout_title': {'en': 'Chest', 'ar': 'صدر'},
      'workout_exercises': [
        {'exercise_id': 'pushUps',          'reps': '10', 'sets': '4', 'rest_seconds': 90},
        {'exercise_id': 'barbellBenchPress', 'reps': '8',  'sets': '3', 'rest_seconds': 60},
      ],
    },
    {
      'day_number'   : 2,
      'workout_title': {'en': 'Back', 'ar': 'ظهر'},
      'workout_exercises': [
        {'exercise_id': 'barbellRow', 'reps': '10', 'sets': '4', 'rest_seconds': 90},
      ],
    },
  ],
};

final Map<String, dynamic> tExerciseData1 = {
  'id'        : 'pushUps',
  'title'     : {'en': 'Push Ups',  'ar': 'ضغط'},
  'form_cues' : {'en': ['Keep back straight'], 'ar': ['حافظ على استقامة ظهرك']},
  'video_url' : 'https://storage.googleapis.com/fitflow-vids/pushups.mp4',
};

final Map<String, dynamic> tExerciseData2 = {
  'id'        : 'barbellBenchPress',
  'title'     : {'en': 'Barbell Bench Press', 'ar': 'بنش برس'},
  'form_cues' : {'en': ['Arch your back'],     'ar': ['قوّس ظهرك']},
  'video_url' : 'https://storage.googleapis.com/fitflow-vids/benchpress.mp4',
};

final Map<String, dynamic> tExerciseData3 = {
  'id'        : 'barbellRow',
  'title'     : {'en': 'Barbell Row', 'ar': 'تجديف بالبار'},
  'form_cues' : {'en': ['Keep core tight'], 'ar': ['شد البطن']},
  'video_url' : 'https://storage.googleapis.com/fitflow-vids/row.mp4',
};

final Map<String, dynamic> tPlanDataEmptyDays = {
  'plan_id'          : 'buildMuscle_2day',
  'goal_id'          : 'buildMuscle',
  'availability_days': 2,
  'workout_days'     : <Map>[],
};

final Map<String, dynamic> tPlanDataEmptyExercises = {
  'plan_id'          : 'buildMuscle_2day',
  'goal_id'          : 'buildMuscle',
  'availability_days': 2,
  'workout_days'     : [
    {
      'day_number'        : 1,
      'workout_title'     : {'en': 'Rest', 'ar': 'راحة'},
      'workout_exercises' : <Map>[],
    },
  ],
};

final WorkoutExerciseModel tWorkoutExercise1 = WorkoutExerciseModel.fromMerged(
  planExercise : {'exercise_id': 'pushUps', 'reps': '10', 'sets': '4', 'rest_seconds': 90},
  exerciseData : tExerciseData1,
);

final ServerFailure tServerFailure = ServerFailure('Server error');