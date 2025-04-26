// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_offline_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserOfflineModelAdapter extends TypeAdapter<UserOfflineModel> {
  @override
  final int typeId = 0;

  @override
  UserOfflineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserOfflineModel(
      name: fields[0] as String,
      job: fields[1] as String,
      id: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserOfflineModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.job)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserOfflineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
