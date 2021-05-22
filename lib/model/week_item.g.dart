// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeekItemAdapter extends TypeAdapter<WeekItem> {
  @override
  final int typeId = 0;

  @override
  WeekItem read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WeekItem.EVEN;
      case 1:
        return WeekItem.UNEVEN;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, WeekItem obj) {
    switch (obj) {
      case WeekItem.EVEN:
        writer.writeByte(0);
        break;
      case WeekItem.UNEVEN:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
