import 'package:hive/hive.dart';

part 'workout_set_model.g.dart';

@HiveType(typeId: 4)
class WorkoutSetModel extends HiveObject {
  @HiveField(0) final int setNumber;
  @HiveField(1) double weight;
  @HiveField(2) int reps;

  WorkoutSetModel({
    required this.setNumber,
    required this.weight,
    required this.reps,
  });

  factory WorkoutSetModel.fromMap(Map<String, dynamic> map) {
    return WorkoutSetModel(
      setNumber : map['set_number'] ?? 0,
      weight    : (map['weight'] ?? 0).toDouble(),
      reps      : int.tryParse(map['reps'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'set_number' : setNumber,
    'weight'     : weight,
    'reps'       : reps,
  };
}