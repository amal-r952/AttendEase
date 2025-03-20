import 'package:attendance_tracker/src/models/attendance_record.dart';
import 'package:attendance_tracker/src/models/student.dart';
import 'package:attendance_tracker/src/screens/view_attendance_data_screen.dart';
import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:attendance_tracker/src/utils/app_toast.dart';
import 'package:attendance_tracker/src/utils/utils.dart';
import 'package:attendance_tracker/src/widgets/build_custom_appbar_widget.dart';
import 'package:attendance_tracker/src/widgets/build_elevated_button.dart';
import 'package:attendance_tracker/src/widgets/build_single_day_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  late Box<Student> studentsBox;
  late Box<AttendanceRecord> attendanceBox;
  DateTime selectedDate = DateTime.now();
  Map<int, bool> attendanceMap = {};

  @override
  void initState() {
    super.initState();
    _openBoxes();
  }

  Future<void> _openBoxes() async {
    studentsBox = Hive.box<Student>('studentsBox');
    attendanceBox = Hive.box<AttendanceRecord>('attendanceBox');

    for (var student in studentsBox.values) {
      attendanceMap[student.studentId] = true;
    }

    setState(() {});
  }

  void _submitAttendance() async {
    List<Student> absentStudents = [];
    List<Student> presentStudents = [];

    studentsBox.values.forEach((student) {
      if (attendanceMap[student.studentId] == false) {
        absentStudents.add(student);
      } else {
        presentStudents.add(student);
      }
    });

    int? existingRecordKey;
    for (var key in attendanceBox.keys) {
      final record = attendanceBox.get(key);
      if (record != null && isSameDate(record.date, selectedDate)) {
        existingRecordKey = key;
        break;
      }
    }

    final newRecord = AttendanceRecord(
      date: selectedDate,
      absentStudents: absentStudents,
      presentStudents: presentStudents,
    );

    if (existingRecordKey != null) {
      await attendanceBox.put(existingRecordKey, newRecord);
    } else {
      await attendanceBox.add(newRecord);
    }

    AppToasts.showSuccessToastTop(context, "Attendance marked successfully!");
    pop(context);
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width * 0.8,
          child: BuildSingleDayPicker(
            initialDate: selectedDate,
            minDate: DateTime(2025),
            maxDate: DateTime.now(),
          ),
        ),
      ),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
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
      body: _buildAttendanceForm(),
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 40, right: 40),
                  child: BuildElevatedButton(
                    backgroundColor: AppColors.primaryColorOrange,
                    width: screenWidth(context),
                    height: screenHeight(context, dividedBy: 18),
                    child: null,
                    txt:
                        "Select Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                    onTap: () {
                      _pickDate(context);
                    },
                  ),
                ),
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
                      if (student == null) return const SizedBox();

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
                                  child:
                                      _buildText(student.studentId.toString())),
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
                                  value:
                                      attendanceMap[student.studentId] ?? true,
                                  onChanged: (value) {
                                    setState(() {
                                      attendanceMap[student.studentId] = value;
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
