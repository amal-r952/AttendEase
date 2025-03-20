import 'package:hive/hive.dart';
import 'student.dart';

part 'attendance_record.g.dart';

@HiveType(typeId: 1)
class AttendanceRecord extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List<Student> absentStudents;

  @HiveField(2)
  List<Student> presentStudents; 

  AttendanceRecord({
    required this.date,
    required this.absentStudents,
    required this.presentStudents, 
  });
}
