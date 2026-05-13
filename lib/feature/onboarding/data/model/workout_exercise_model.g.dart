// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_exercise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutExerciseModelAdapter extends TypeAdapter<WorkoutExerciseModel> {
  @override
  final int typeId = 1;

  @override
  WorkoutExerciseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutExerciseModel(
      exerciseId: fields[0] as String,
      restSeconds: fields[1] as int,
      sets: fields[2] as String,
      reps: fields[3] as String,
      titleEn: fields[4] as String,
      titleAr: fields[5] as String,
      formCuesEn: (fields[6] as List).cast<String>(),
      formCuesAr: (fields[7] as List).cast<String>(),
      videoUrl: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutExerciseModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.exerciseId)
      ..writeByte(1)
      ..write(obj.restSeconds)
      ..writeByte(2)
      ..write(obj.sets)
      ..writeByte(3)
      ..write(obj.reps)
      ..writeByte(4)
      ..write(obj.titleEn)
      ..writeByte(5)
      ..write(obj.titleAr)
      ..writeByte(6)
      ..write(obj.formCuesEn)
      ..writeByte(7)
      ..write(obj.formCuesAr)
      ..writeByte(8)
      ..write(obj.videoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutExerciseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
