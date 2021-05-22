// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonsResponseAdapter extends TypeAdapter<LessonsResponse> {
  @override
  final int typeId = 2;

  @override
  LessonsResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonsResponse(
      (fields[0] as List)?.cast<LessonModel>(),
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LessonsResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lessons)
      ..writeByte(1)
      ..write(obj.error);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonsResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
