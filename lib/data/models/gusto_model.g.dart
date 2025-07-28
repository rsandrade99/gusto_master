// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gusto_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GustoModelAdapter extends TypeAdapter<GustoModel> {
  @override
  final int typeId = 0;

  @override
  GustoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GustoModel(
      id: fields[0] as String,
      nombre: fields[1] as String,
      tipo: fields[2] as String,
      datosApi: (fields[3] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, GustoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.tipo)
      ..writeByte(3)
      ..write(obj.datosApi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GustoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
