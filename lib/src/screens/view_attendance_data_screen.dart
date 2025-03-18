import 'dart:io';

import 'package:attendance_tracker/src/models/attendance_record.dart';
import 'package:attendance_tracker/src/models/student.dart';
import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:attendance_tracker/src/utils/app_toast.dart';
import 'package:attendance_tracker/src/utils/utils.dart';
import 'package:attendance_tracker/src/widgets/build_custom_appbar_widget.dart';
import 'package:attendance_tracker/src/widgets/build_elevated_button.dart';
import 'package:attendance_tracker/src/widgets/build_single_day_picker.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ViewAttendanceDataScreen extends StatefulWidget {
  const ViewAttendanceDataScreen({super.key});

  @override
  State<ViewAttendanceDataScreen> createState() =>
      _ViewAttendanceDataScreenState();
}

class _ViewAttendanceDataScreenState extends State<ViewAttendanceDataScreen> {
  late Box<AttendanceRecord> attendanceBox;
  DateTime selectedDate = DateTime.now();
  List<Student> absentees = [];

  @override
  void initState() {
    super.initState();
    attendanceBox = Hive.box<AttendanceRecord>('attendanceBox');
    _loadAbsentees();
  }

  Future<void> _downloadCSV() async {
    if (absentees.isEmpty) {
      AppToasts.showInfoToastTop(context, "Nothing to download!");
      return;
    }

    if (await _requestStoragePermission()) {
      try {
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

        // Path to the Downloads folder
        String downloadsPath = "/storage/emulated/0/Download";

        // File path inside Downloads
        String filePath = "$downloadsPath/Attendance_$formattedDate.csv";

        List<List<String>> csvData = [
          ["Student ID", "Name", "Roll No", "Course"],
          ...absentees.map((student) => [
                student.studentId.toString(),
                student.studentName,
                student.rollNumber.toString(),
                student.courseName,
              ]),
        ];

        String csv = const ListToCsvConverter().convert(csvData);

        File file = File(filePath);
        await file.writeAsString(csv);

        AppToasts.showSuccessToastTop(
            context, "File saved in Downloads folder!");
      } catch (e) {
        AppToasts.showErrorToastTop(
            context, "Error saving file: ${e.toString()}");
      }
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        return true;
      } else if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  Future<void> _loadAbsentees() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    setState(() {
      absentees = attendanceBox.values
          .where((record) =>
              DateFormat('yyyy-MM-dd').format(record.date) == formattedDate)
          .expand((record) =>
              (record.absentStudents as List<dynamic>).cast<Student>())
          .toList();
    });
  }

  Future<DateTime?> getOldestAttendanceDate() async {
    Box<AttendanceRecord> attendanceBox =
        Hive.box<AttendanceRecord>('attendanceBox');

    if (attendanceBox.isEmpty) {
      return null;
    }

    List<DateTime> dates =
        attendanceBox.values.map((record) => record.date).toList();
    dates.sort();

    return dates.first;
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime initialDate = await getOldestAttendanceDate() ?? DateTime.now();
    DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width * 0.8,
          child: BuildSingleDayPicker(
            initialDate: selectedDate,
            minDate: initialDate,
            maxDate: DateTime.now(),
          ),
        ),
      ),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _loadAbsentees();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildCustomAppBarWidget(
        title: "View Attendance",
        showBackButton: false,
      ),
      body: Padding(
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
            Expanded(
              child: absentees.isEmpty
                  ? const Center(
                      child: Text("No absentees recorded for this date."))
                  : Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.all(3),
                          color: AppColors.primaryColorOrange,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Student ID",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Name",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Roll No",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Course",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: absentees.length,
                            itemBuilder: (context, index) {
                              final student = absentees[index];
                              return Card(
                                margin: const EdgeInsets.all(3),
                                color: Theme.of(context).cardColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          student.studentId.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          student.studentName,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          student.rollNumber.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          student.courseName,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
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
                            txt: "DOWNLOAD ",
                            onTap: () {
                              _downloadCSV();
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
