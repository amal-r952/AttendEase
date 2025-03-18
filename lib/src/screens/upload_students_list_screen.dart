import 'dart:convert';
import 'dart:io';

import 'package:attendance_tracker/src/models/attendance_record.dart';
import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:attendance_tracker/src/utils/app_toast.dart';
import 'package:attendance_tracker/src/utils/utils.dart';
import 'package:attendance_tracker/src/widgets/build_custom_appbar_widget.dart';
import 'package:attendance_tracker/src/widgets/build_elevated_button.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/student.dart';

class UploadStudentsListScreen extends StatefulWidget {
  const UploadStudentsListScreen({Key? key}) : super(key: key);

  @override
  State<UploadStudentsListScreen> createState() =>
      _UploadStudentsListScreenState();
}

class _UploadStudentsListScreenState extends State<UploadStudentsListScreen> {
  List<List<dynamic>> _data = [];
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildCustomAppBarWidget(
        title: "Upload Student Data",
        showBackButton: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: _data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (_, index) {
                  return Card(
                    margin: const EdgeInsets.all(3),
                    color: index == 0
                        ? AppColors.primaryColorOrange
                        : Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              _data[index][0].toString(),
                              textAlign: TextAlign.center,
                              style: index == 0
                                  ? Theme.of(context).textTheme.bodyLarge
                                  : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              _data[index][1].toString(),
                              textAlign: TextAlign.center,
                              style: index == 0
                                  ? Theme.of(context).textTheme.bodyLarge
                                  : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              _data[index][2].toString(),
                              textAlign: TextAlign.center,
                              style: index == 0
                                  ? Theme.of(context).textTheme.bodyLarge
                                  : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: BuildElevatedButton(
                backgroundColor: AppColors.primaryColorOrange,
                width: screenWidth(context),
                height: screenHeight(context, dividedBy: 18),
                child: null,
                txt: "PICK FILE",
                onTap: () {
                  _pickFile();
                }),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 30),
            child: BuildElevatedButton(
              backgroundColor: AppColors.primaryColorOrange,
              width: screenWidth(context),
              height: screenHeight(context, dividedBy: 18),
              child: null,
              txt: "ADD DATA",
              onTap: () async {
                var studentsBox = Hive.box<Student>('studentsBox');
                var attendanceBox = Hive.box<AttendanceRecord>('attendanceBox');

                // Clear both boxes
                await studentsBox.clear();
                await attendanceBox.clear();

                int studentId = 0;
                for (var element in _data.skip(1)) {
                  if (element.length >= 3) {
                    studentId++;
                    var student = Student(
                      studentId: studentId,
                      studentName: element[0].toString(),
                      rollNumber: int.tryParse(element[1].toString()) ?? 0,
                      courseName: element[2].toString(),
                    );

                    await studentsBox.add(student);
                  }
                }

                AppToasts.showSuccessToastTop(
                    context, "Student list updated successfully!");
                pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["csv"],
      allowMultiple: false,
    );

    if (result == null) return;
    filePath = result.files.first.path!;

    if (!filePath!.toLowerCase().endsWith('.csv')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a valid CSV file")),
      );
      return;
    }

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter(eol: "\n"))
        .toList();

    setState(() {
      _data = fields;
    });

    for (var row in _data) {
      print(row);
    }
    print("Total Rows: ${_data.length}");
  }
}
