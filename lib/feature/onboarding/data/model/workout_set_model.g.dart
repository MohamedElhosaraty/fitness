// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutSetModelAdapter extends TypeAdapter<WorkoutSetModel> {
  @override
  final int typeId = 4;

  @override
  WorkoutSetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutSetModel(
      setNumber: fields[0] as int,
      weight: fields[1] as double,
      reps: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutSetModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.setNumber)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.reps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
