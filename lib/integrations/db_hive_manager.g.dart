// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_hive_manager.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedUrlAdapter extends TypeAdapter<SavedUrl> {
  @override
  final int typeId = 1;

  @override
  SavedUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedUrl(
      alias: fields[1] as String?,
      url: fields[2] as String?,
      urlShort: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedUrl obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.alias)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.urlShort);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
