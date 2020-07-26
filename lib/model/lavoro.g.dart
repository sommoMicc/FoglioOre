// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lavoro.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LavoroAdapter extends TypeAdapter<Lavoro> {
  @override
  final int typeId = 92;

  @override
  Lavoro read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lavoro()
      .._cantiere = fields[0]
      .._lavorato = fields[1] as bool
      .._motivoAssenza = fields[2] as MotivoAssenza
      .._minutiLavorati = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, Lavoro obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._cantiere)
      ..writeByte(1)
      ..write(obj._lavorato)
      ..writeByte(2)
      ..write(obj._motivoAssenza)
      ..writeByte(3)
      ..write(obj._minutiLavorati);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LavoroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
