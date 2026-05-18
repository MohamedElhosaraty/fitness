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
        {
          'exercise_id': 'pushUps',
          'rest_seconds': 90,
          'sets': [
            {'set_number': 1, 'weight': 0, 'reps': '10'},
            {'set_number': 2, 'weight': 0, 'reps': '10'},
            {'set_number': 3, 'weight': 0, 'reps': '10'},
            {'set_number': 4, 'weight': 0, 'reps': '10'},
          ],
        },
        {
          'exercise_id': 'barbellBenchPress',
          'rest_seconds': 60,
          'sets': [
            {'set_number': 1, 'weight': 40, 'reps': '8'},
            {'set_number': 2, 'weight': 45, 'reps': '8'},
            {'set_number': 3, 'weight': 50, 'reps': '8'},
          ],
        },
      ],
    },
    {
      'day_number'   : 2,
      'workout_title': {'en': 'Back', 'ar': 'ظهر'},
      'workout_exercises': [
        {
          'exercise_id': 'barbellRow',
          'rest_seconds': 90,
          'sets': [
            {'set_number': 1, 'weight': 40, 'reps': '10'},
            {'set_number': 2, 'weight': 40, 'reps': '10'},
            {'set_number': 3, 'weight': 40, 'reps': '10'},
            {'set_number': 4, 'weight': 40, 'reps': '10'},
          ],
        },
      ],
    },
  ],
};

// exercise data بدون تغيير
final Map<String, dynamic> tExerciseData1 = {
  'id'        : 'pushUps',
  'title'     : {'en': 'Push Ups', 'ar': 'ضغط'},
  'form_cues' : {'en': ['Keep back straight'], 'ar': ['حافظ على استقامة ظهرك']},
  'video_url' : 'https://storage.googleapis.com/fitflow-vids/pushups.mp4',
};

final Map<String, dynamic> tExerciseData2 = {
  'id'        : 'barbellBenchPress',
  'title'     : {'en': 'Barbell Bench Press', 'ar': 'بنش برس'},
  'form_cues' : {'en': ['Arch your back'], 'ar': ['قوّس ظهرك']},
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

// ✅ tWorkoutExercise1 بالشكل الجديد
final WorkoutExerciseModel tWorkoutExercise1 = WorkoutExerciseModel.fromMerged(
  planExercise: {
    'exercise_id' : 'pushUps',
    'rest_seconds': 90,
    'sets': [
      {'set_number': 1, 'weight': 0, 'reps': '10'},
      {'set_number': 2, 'weight': 0, 'reps': '10'},
      {'set_number': 3, 'weight': 0, 'reps': '10'},
      {'set_number': 4, 'weight': 0, 'reps': '10'},
    ],
  },
  exerciseData: tExerciseData1,
);

final ServerFailure tServerFailure = ServerFailure('Server error');