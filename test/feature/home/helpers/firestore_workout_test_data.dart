import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/feature/home/data/model/exercise_model.dart';

const String tGoal     = 'buildMuscle';
const int    tDays     = 2;
const int    tIndexDay = 1;
const String tPlanId   = 'buildMuscle2Days';
const String tDayId    = 'day1';

final Map<String, dynamic> tDayData = {
  'category'    : {'en': 'Chest', 'ar': 'صدر'},
  'exerciseRefs': ['push_up', 'bench_press'],
};

final Map<String, dynamic> tDayDataEmptyRefs = {
  'category'    : {'en': 'Rest', 'ar': 'راحة'},
  'exerciseRefs': <String>[],
};

final Map<String, dynamic> tDayDataNoRefsKey = {
  'category': {'en': 'Rest', 'ar': 'راحة'},
};

final Map<String, dynamic> tDayDataNoCategoryKey = {
  'exerciseRefs': <String>[],
};

final Map<String, dynamic> tExerciseData1 = {
  'id'      : 'push_up',
  'name'    : {'en': 'Push Up',     'ar': 'ضغط'},
  'subtitle': {'en': 'Chest focus', 'ar': 'تركيز صدر'},
  'sets'    : '3',
  'repsMin' : '10',
  'repsMax' : '15',
};

final Map<String, dynamic> tExerciseData2 = {
  'id'      : 'bench_press',
  'name'    : {'en': 'Bench Press', 'ar': 'بنش برس'},
  'subtitle': {'en': 'Strength',    'ar': 'قوة'},
  'sets'    : '4',
  'repsMin' : '8',
  'repsMax' : '12',
};

final ExerciseModel tExercise1 = ExerciseModel.fromMap(tExerciseData1);
final ExerciseModel tExercise2 = ExerciseModel.fromMap(tExerciseData2);

final ServerFailure tServerFailure = ServerFailure('Server error');
