// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      studentId: fields[0] as int,
      studentName: fields[1] as String,
      rollNumber: fields[2] as int,
      courseName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.studentId)
      ..writeByte(1)
      ..write(obj.studentName)
      ..writeByte(2)
      ..write(obj.rollNumber)
      ..writeByte(3)
      ..write(obj.courseName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
