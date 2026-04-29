class ExerciseModel {
  final String id;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final String sets;
  final String repsMin;
  final String repsMax;

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
      id:          map['id'] ?? '',
      titleEn:     name['en'] ?? '',
      titleAr:     name['ar'] ?? '',
      subtitleEn:  subtitle['en'] ?? '',
      subtitleAr:  subtitle['ar'] ?? '',
      sets:    map['sets'] ?? '0',
      repsMin: map['repsMin'] ?? '0',
      repsMax: map['repsMax'] ?? '0',
    );
  }

  String getTitle(String lang)    => lang == 'ar' ? titleAr : titleEn;
  String getSubtitle(String lang) => lang == 'ar' ? subtitleAr : subtitleEn;
  String get repsDisplay          => '$sets x $repsMin-$repsMax';
}