// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stato.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GlobalAppStateAdapter extends TypeAdapter<GlobalAppState> {
  @override
  final int typeId = 91;

  @override
  GlobalAppState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlobalAppState(
      (fields[0] as Map)?.map((dynamic k, dynamic v) =>
          MapEntry(k as DateTime, (v as List)?.cast<Lavoro>())),
    );
  }

  @override
  void write(BinaryWriter writer, GlobalAppState obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._dati);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalAppStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
