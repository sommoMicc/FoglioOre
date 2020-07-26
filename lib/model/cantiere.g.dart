// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cantiere.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CantiereAdapter extends TypeAdapter<Cantiere> {
  @override
  final int typeId = 93;

  @override
  Cantiere read(BinaryReader reader) {
    switch (reader.readInt()) {
      case 0:
        return Cantiere.Confindustria;
      case 1:
        return Cantiere.Assimoco;
    }
    return Cantiere.Confindustria;
  }

  @override
  void write(BinaryWriter writer, Cantiere obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CantiereAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
