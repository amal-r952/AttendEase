import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  int studentId;

  @HiveField(1)
  String studentName;

  @HiveField(2)
  int rollNumber;

  @HiveField(3)
  String courseName;

  Student({
    required this.studentId,
    required this.studentName,
    required this.rollNumber,
    required this.courseName,
  });
}
