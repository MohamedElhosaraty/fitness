import 'package:hive/hive.dart';

part 'workout_exercise_model.g.dart';

@HiveType(typeId: 1)
class WorkoutExerciseModel extends HiveObject {
  @HiveField(0)
  final String exerciseId;
  @HiveField(1)
  final int restSeconds;
  @HiveField(2)
  final String sets;
  @HiveField(3)
  final String reps;
  @HiveField(4)
  final String titleEn;
  @HiveField(5)
  final String titleAr;
  @HiveField(6)
  final List<String> formCuesEn;
  @HiveField(7)
  final List<String> formCuesAr;
  @HiveField(8)
  final String videoUrl;

  WorkoutExerciseModel({
    required this.exerciseId,
    required this.restSeconds,
    required this.sets,
    required this.reps,
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

    return WorkoutExerciseModel(
      exerciseId: planExercise['exercise_id'] ?? '',
      restSeconds: planExercise['rest_seconds'] ?? 0,
      sets: planExercise['sets'] ?? '',
      reps: planExercise['reps'] ?? '',
      titleEn: title['en'] ?? '',
      titleAr: title['ar'] ?? '',
      formCuesEn: List<String>.from(formCues['en'] ?? []),
      formCuesAr: List<String>.from(formCues['ar'] ?? []),
      videoUrl: exerciseData['video_url'] ?? '',
    );
  }

  String getTitle(String lang) => lang == 'ar' ? titleAr : titleEn;
  List<String> getFormCues(String lang) => lang == 'ar' ? formCuesAr : formCuesEn;

  String get setAndReps =>
      "$sets * $reps";
}