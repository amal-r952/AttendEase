import 'package:attendance_tracker/src/app.dart';
import 'package:attendance_tracker/src/models/attendance_record.dart';
import 'package:attendance_tracker/src/models/student.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(AttendanceRecordAdapter());

  await Hive.openBox<Student>('studentsBox');
  await Hive.openBox<AttendanceRecord>('attendanceBox');

  runApp(DevicePreview(
    enabled: false,
    builder: (context) {
      return MyApp();
    },
  ));
}
