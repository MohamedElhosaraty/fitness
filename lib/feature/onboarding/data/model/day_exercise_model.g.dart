// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_exercise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayExerciseModelAdapter extends TypeAdapter<DayExerciseModel> {
  @override
  final int typeId = 1;

  @override
  DayExerciseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayExerciseModel(
      categoryEn: fields[0] as String,
      categoryAr: fields[1] as String,
      exerciseRefs: (fields[2] as List).cast<ExerciseModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayExerciseModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.categoryEn)
      ..writeByte(1)
      ..write(obj.categoryAr)
      ..writeByte(2)
      ..write(obj.exerciseRefs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayExerciseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
