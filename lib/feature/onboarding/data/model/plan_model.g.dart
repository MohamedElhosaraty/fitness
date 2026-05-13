// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanModelAdapter extends TypeAdapter<PlanModel> {
  @override
  final int typeId = 3;

  @override
  PlanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanModel(
      planId: fields[0] as String,
      goalId: fields[1] as String,
      availabilityDays: fields[2] as int,
      workoutDays: (fields[3] as List).cast<WorkoutDayModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlanModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.planId)
      ..writeByte(1)
      ..write(obj.goalId)
      ..writeByte(2)
      ..write(obj.availabilityDays)
      ..writeByte(3)
      ..write(obj.workoutDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
