// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseModelAdapter extends TypeAdapter<ExerciseModel> {
  @override
  final int typeId = 0;

  @override
  ExerciseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseModel(
      id: fields[0] as String,
      titleEn: fields[1] as String,
      titleAr: fields[2] as String,
      subtitleEn: fields[3] as String,
      subtitleAr: fields[4] as String,
      sets: fields[5] as String,
      repsMin: fields[6] as String,
      repsMax: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleEn)
      ..writeByte(2)
      ..write(obj.titleAr)
      ..writeByte(3)
      ..write(obj.subtitleEn)
      ..writeByte(4)
      ..write(obj.subtitleAr)
      ..writeByte(5)
      ..write(obj.sets)
      ..writeByte(6)
      ..write(obj.repsMin)
      ..writeByte(7)
      ..write(obj.repsMax);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
