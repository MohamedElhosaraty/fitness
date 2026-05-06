import 'package:hive/hive.dart';
part 'exercise_model.g.dart';

@HiveType(typeId: 0)
class ExerciseModel extends HiveObject {
  @HiveField(0) final String id;
  @HiveField(1) final String titleEn;
  @HiveField(2) final String titleAr;
  @HiveField(3) final String subtitleEn;
  @HiveField(4) final String subtitleAr;
  @HiveField(5) final String sets;
  @HiveField(6) final String repsMin;
  @HiveField(7) final String repsMax;

  ExerciseModel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.sets,
    required this.repsMin,
    required this.repsMax,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    final name     = Map<String, dynamic>.from(map['name'] ?? {});
    final subtitle = Map<String, dynamic>.from(map['subtitle'] ?? {});
    return ExerciseModel(
      id:         map['id'] ?? '',
      titleEn:    name['en'] ?? '',
      titleAr:    name['ar'] ?? '',
      subtitleEn: subtitle['en'] ?? '',
      subtitleAr: subtitle['ar'] ?? '',
      sets:       map['sets'] ?? '0',
      repsMin:    map['repsMin'] ?? '0',
      repsMax:    map['repsMax'] ?? '0',
    );
  }

  String getTitle(String lang)    => lang == 'ar' ? titleAr : titleEn;
  String getSubtitle(String lang) => lang == 'ar' ? subtitleAr : subtitleEn;
  String get repsDisplay          => '$sets x $repsMin-$repsMax';
}