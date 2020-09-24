// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lavoro.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MotivoAssenzaAdapter extends TypeAdapter<MotivoAssenza> {
  @override
  final int typeId = 100;

  @override
  MotivoAssenza read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MotivoAssenza.NONE;
      case 1:
        return MotivoAssenza.PERMESSO;
      case 2:
        return MotivoAssenza.FERIE;
      case 3:
        return MotivoAssenza.LUTTO;
      case 4:
        return MotivoAssenza.FESTIVITA;
      case 5:
        return MotivoAssenza.ALTRO;
      case 6:
        return MotivoAssenza.MALATTIA;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, MotivoAssenza obj) {
    switch (obj) {
      case MotivoAssenza.NONE:
        writer.writeByte(0);
        break;
      case MotivoAssenza.PERMESSO:
        writer.writeByte(1);
        break;
      case MotivoAssenza.FERIE:
        writer.writeByte(2);
        break;
      case MotivoAssenza.LUTTO:
        writer.writeByte(3);
        break;
      case MotivoAssenza.FESTIVITA:
        writer.writeByte(4);
        break;
      case MotivoAssenza.ALTRO:
        writer.writeByte(5);
        break;
      case MotivoAssenza.MALATTIA:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MotivoAssenzaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      .._cantiere = fields[0] as Cantiere
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
