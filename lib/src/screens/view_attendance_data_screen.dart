import 'dart:io';

import 'package:attendance_tracker/src/models/attendance_record.dart';
import 'package:attendance_tracker/src/models/student.dart';
import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:attendance_tracker/src/utils/app_toast.dart';
import 'package:attendance_tracker/src/utils/utils.dart';
import 'package:attendance_tracker/src/widgets/build_calender_days_range_picker.dart';
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
  DateTime? selectedDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
  List<Student> students = [];
  int _selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    attendanceBox = Hive.box<AttendanceRecord>('attendanceBox');
    _loadAbsentees();
  }

  Future<void> _downloadCSV() async {
    if (students.isEmpty) {
      AppToasts.showInfoToastTop(context, "Nothing to download!");
      return;
    }

    if (await _requestStoragePermission()) {
      try {
        String downloadsPath = "/storage/emulated/0/Download";
        String fileName = "";

        if (_selectedFilter == 0) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
          fileName = "Absent_$formattedDate.csv";
        } else if (_selectedFilter == 1) {
          String formattedStartDate =
              DateFormat('yyyy-MM-dd').format(startDate!);
          String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate!);
          fileName = "Absent_${formattedStartDate}_to_$formattedEndDate.csv";
        } else if (_selectedFilter == 2) {
          String formattedStartDate =
              DateFormat('yyyy-MM-dd').format(startDate!);
          String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate!);
          fileName = "Present_${formattedStartDate}_to_$formattedEndDate.csv";
        }

        String filePath = "$downloadsPath/$fileName";

        List<List<String>> csvData = [
          ["Student ID", "Name", "Roll No", "Course"],
          ...students.map((student) => [
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
            context, "File saved in Downloads folder as $fileName!");
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
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    setState(() {
      students = attendanceBox.values
          .where((record) =>
              DateFormat('yyyy-MM-dd').format(record.date) == formattedDate)
          .expand((record) =>
              (record.absentStudents as List<dynamic>).cast<Student>())
          .toList();
    });
  }

  Future<void> _load100Present() async {
    if (startDate == null || endDate == null) return;
    int totalDays = endDate!.difference(startDate!).inDays + 1;
    Map<int, int> presentCount = {};
    for (var record in attendanceBox.values.where((record) =>
        record.date.isAfter(startDate!.subtract(const Duration(days: 1))) &&
        record.date.isBefore(endDate!.add(const Duration(days: 1))))) {
      for (var student in record.presentStudents) {
        presentCount[student.studentId] =
            (presentCount[student.studentId] ?? 0) + 1;
      }
    }
    setState(() {
      students = presentCount.entries
          .where((entry) => entry.value == totalDays)
          .map((entry) => attendanceBox.values
              .expand((record) => record.presentStudents)
              .firstWhere((student) => student.studentId == entry.key))
          .toList();
    });
  }

  Future<void> _load100Absent() async {
    if (startDate == null || endDate == null) return;
    int totalDays = endDate!.difference(startDate!).inDays + 1;
    Map<int, int> absentCount = {};
    for (var record in attendanceBox.values.where((record) =>
        record.date.isAfter(startDate!.subtract(const Duration(days: 1))) &&
        record.date.isBefore(endDate!.add(const Duration(days: 1))))) {
      for (var student in record.absentStudents) {
        absentCount[student.studentId] =
            (absentCount[student.studentId] ?? 0) + 1;
      }
    }
    setState(() {
      students = absentCount.entries
          .where((entry) => entry.value == totalDays)
          .map((entry) => attendanceBox.values
              .expand((record) => record.absentStudents)
              .firstWhere((student) => student.studentId == entry.key))
          .toList();
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width * 0.8,
          child: BuildSingleDayPicker(
            initialDate: selectedDate!,
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
      _loadAbsentees();
    }
  }

  void _pickDateRange(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 600,
            child: BuildCalenderDaysRangePicker(
              onRangeSelected: (value) {
                setState(() {
                  startDate = value.start;
                  endDate = value.end;
                });
                print("START DATE: $startDate");
                print("END DATE: $endDate");
                if (startDate != null && endDate != null) {
                  if (_selectedFilter == 1) {
                    _load100Absent();
                  } else if (_selectedFilter == 2) {
                    _load100Present();
                  }
                }
              },
            ),
          ),
        );
      },
    );
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
            RadioListTile<int>(
              title: Text(
                "Absentees of Selected Date",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: 0,
              activeColor: AppColors.primaryColorOrange,
              groupValue: _selectedFilter,
              onChanged: (int? value) {
                setState(() {
                  _selectedFilter = value!;
                  students.clear();
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                    color: AppColors.primaryColorOrange.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 8),
            RadioListTile<int>(
              title: Text(
                "100% Absent",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: 1,
              activeColor: AppColors.primaryColorOrange,
              groupValue: _selectedFilter,
              onChanged: (int? value) {
                setState(() {
                  _selectedFilter = value!;
                  // selectedDate = DateTime(year);
                  students.clear();
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                    color: AppColors.primaryColorOrange.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 8),
            RadioListTile<int>(
              title: Text(
                "100% Present",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: 2,
              activeColor: AppColors.primaryColorOrange,
              groupValue: _selectedFilter,
              onChanged: (int? value) {
                setState(() {
                  _selectedFilter = value!;
                  students.clear();
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                    color: AppColors.primaryColorOrange.withOpacity(0.5)),
              ),
            ),
            // const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BuildElevatedButton(
                backgroundColor: AppColors.primaryColorOrange,
                width: screenWidth(context),
                height: screenHeight(context, dividedBy: 18),
                child: null,
                txt: _selectedFilter == 0
                    ? (selectedDate != null
                        ? "Selected date ${DateFormat('yyyy-MM-dd').format(selectedDate!)}"
                        : "Select Date")
                    : (startDate != null && endDate != null
                        ? "Selectd range ${DateFormat('yyyy-MM-dd').format(startDate!)} - ${DateFormat('yyyy-MM-dd').format(endDate!)}"
                        : "Select Date Range"),
                onTap: () {
                  if (_selectedFilter == 0) {
                    _pickDate(context);
                  } else {
                    _pickDateRange(context);
                  }
                },
              ),
            ),
            // const SizedBox(height: 10),
            Expanded(
              child: students.isEmpty
                  ? const Center(
                      child: Text("No absentees recorded for this date/range."))
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
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              final student = students[index];
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
