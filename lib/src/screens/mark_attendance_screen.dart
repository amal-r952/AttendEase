import 'package:attendance_tracker/src/models/attendance_record.dart';
import 'package:attendance_tracker/src/models/student.dart';
import 'package:attendance_tracker/src/screens/view_attendance_data_screen.dart';
import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:attendance_tracker/src/utils/app_toast.dart';
import 'package:attendance_tracker/src/utils/utils.dart';
import 'package:attendance_tracker/src/widgets/build_custom_appbar_widget.dart';
import 'package:attendance_tracker/src/widgets/build_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  late Box<Student> studentsBox;
  late Box<AttendanceRecord> attendanceBox;
  Map<int, bool> attendanceMap = {};
  bool hasSubmittedToday = false;

  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  Future<void> _openBoxes() async {
    studentsBox = Hive.box<Student>('studentsBox');
    attendanceBox = Hive.box<AttendanceRecord>('attendanceBox');

    hasSubmittedToday = attendanceBox.values.any((record) {
      return record.date.year == DateTime.now().year &&
          record.date.month == DateTime.now().month &&
          record.date.day == DateTime.now().day;
    });

    if (!hasSubmittedToday) {
      for (int i = 0; i < studentsBox.length; i++) {
        attendanceMap[i] = true;
      }
    }

    setState(() {});
  }

  void _submitAttendance() async {
    if (hasSubmittedToday) return;

    List<Student> absentStudents = [];

    attendanceMap.forEach((index, isPresent) {
      if (!isPresent) {
        final student = studentsBox.getAt(index);
        if (student != null) {
          absentStudents.add(student);
        }
      }
    });

    final record = AttendanceRecord(
      date: DateTime.now(),
      absentStudents: absentStudents,
    );

    await attendanceBox.add(record);
    setState(() {
      hasSubmittedToday = true;
    });

    AppToasts.showSuccessToastTop(context, "Attendance marked successfully!");
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildCustomAppBarWidget(
        title: "Mark Attendance",
        showBackButton: false,
        showTrailingIcon: true,
        trailingIcon: const Icon(Icons.receipt_long_rounded),
        trailingIconSize: 30,
        onTrailingIconPressed: () {
          push(context, const ViewAttendanceDataScreen());
        },
      ),
      body: hasSubmittedToday
          ? Center(
              child: Text(
                "You have already submitted today's attendance.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : _buildAttendanceForm(),
    );
  }

  Widget _buildAttendanceForm() {
    return studentsBox.isEmpty
        ? Center(
            child: Text(
              "No students found.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                // Column headers
                Card(
                  margin: const EdgeInsets.all(3),
                  color: AppColors.primaryColorOrange,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: _buildHeader("Student ID")),
                        Expanded(flex: 3, child: _buildHeader("Name")),
                        Expanded(flex: 2, child: _buildHeader("Roll No")),
                        Expanded(flex: 3, child: _buildHeader("Course")),
                        Expanded(flex: 2, child: _buildHeader("Present")),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Student list
                Expanded(
                  child: ListView.builder(
                    itemCount: studentsBox.length,
                    itemBuilder: (context, index) {
                      final student = studentsBox.getAt(index);
                      return Card(
                        margin: const EdgeInsets.all(3),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: _buildText(
                                      student!.studentId.toString())),
                              Expanded(
                                  flex: 3,
                                  child: _buildText(student.studentName)),
                              Expanded(
                                  flex: 2,
                                  child: _buildText(
                                      student.rollNumber.toString())),
                              Expanded(
                                  flex: 3,
                                  child: _buildText(student.courseName)),
                              Expanded(
                                flex: 2,
                                child: Switch(
                                  activeColor: Theme.of(context).cardColor,
                                  activeTrackColor:
                                      AppColors.primaryColorOrange,
                                  value: attendanceMap[index] ?? true,
                                  onChanged: (value) {
                                    setState(() {
                                      attendanceMap[index] = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: BuildElevatedButton(
                    backgroundColor: AppColors.primaryColorOrange,
                    width: screenWidth(context),
                    height: screenHeight(context, dividedBy: 18),
                    child: null,
                    txt: "SUBMIT ATTENDANCE",
                    onTap: _submitAttendance,
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildHeader(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
