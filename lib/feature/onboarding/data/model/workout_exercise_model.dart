import 'package:hive/hive.dart';
import 'workout_set_model.dart';

part 'workout_exercise_model.g.dart';

@HiveType(typeId: 1)
class WorkoutExerciseModel extends HiveObject {
  @HiveField(0)
  final String exerciseId;
  @HiveField(1)
  final int restSeconds;
  @HiveField(2)
  List<WorkoutSetModel> sets;
  @HiveField(3)
  final String titleEn;
  @HiveField(4)
  final String titleAr;
  @HiveField(5)
  final List<String> formCuesEn;
  @HiveField(6)
  final List<String> formCuesAr;
  @HiveField(7)
  final String videoUrl;

  WorkoutExerciseModel({
    required this.exerciseId,
    required this.restSeconds,
    required this.sets,
    required this.titleEn,
    required this.titleAr,
    required this.formCuesEn,
    required this.formCuesAr,
    required this.videoUrl,
  });

  factory WorkoutExerciseModel.fromMerged({
    required Map<String, dynamic> planExercise,
    required Map<String, dynamic> exerciseData,
  }) {
    final title = Map<String, dynamic>.from(exerciseData['title'] ?? {});
    final formCues = Map<String, dynamic>.from(exerciseData['form_cues'] ?? {});
    final rawSets = planExercise['sets'] as List;

    return WorkoutExerciseModel(
      exerciseId: planExercise['exercise_id'] ?? '',
      restSeconds: planExercise['rest_seconds'] ?? 0,
      sets:
          rawSets
              .map((s) => WorkoutSetModel.fromMap(Map<String, dynamic>.from(s)))
              .toList(),
      titleEn: title['en'] ?? '',
      titleAr: title['ar'] ?? '',
      formCuesEn: List<String>.from(formCues['en'] ?? []),
      formCuesAr: List<String>.from(formCues['ar'] ?? []),
      videoUrl: exerciseData['video_url'] ?? '',
    );
  }

  void updateSet(int index, {double? weight, int? reps}) {
    if (weight != null) sets[index].weight = weight;
    if (reps != null) sets[index].reps = reps;
  }

  String getTitle(String lang) => lang == 'ar' ? titleAr : titleEn;

  List<String> getFormCues(String lang) =>
      lang == 'ar' ? formCuesAr : formCuesEn;

  int get totalSets => sets.length;

  String get setAndReps =>
      sets.isEmpty ? '0 sets' : '$totalSets * ${sets[0].reps}';
}
