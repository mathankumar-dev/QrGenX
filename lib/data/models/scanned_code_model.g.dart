// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_code_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScannedCodeModelAdapter extends TypeAdapter<ScannedCodeModel> {
  @override
  final int typeId = 0;

  @override
  ScannedCodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScannedCodeModel(
      value: fields[0] as String,
      type: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ScannedCodeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannedCodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
