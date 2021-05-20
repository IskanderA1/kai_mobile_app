// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonModelAdapter extends TypeAdapter<LessonModel> {
  @override
  final int typeId = 1;

  @override
  LessonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonModel(
      dayNum: fields[0] as int,
      dayTime: fields[1] as String,
      dayEven: fields[2] as WeekItem,
      dayDate: fields[3] as String,
      disciplineName: fields[4] as String,
      disciplineType: fields[5] as String,
      audNum: fields[6] as String,
      buildNum: fields[7] as String,
      prepodName: fields[8] as String,
      orgName: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LessonModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.dayNum)
      ..writeByte(1)
      ..write(obj.dayTime)
      ..writeByte(2)
      ..write(obj.dayEven)
      ..writeByte(3)
      ..write(obj.dayDate)
      ..writeByte(4)
      ..write(obj.disciplineName)
      ..writeByte(5)
      ..write(obj.disciplineType)
      ..writeByte(6)
      ..write(obj.audNum)
      ..writeByte(7)
      ..write(obj.buildNum)
      ..writeByte(8)
      ..write(obj.prepodName)
      ..writeByte(9)
      ..write(obj.orgName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
