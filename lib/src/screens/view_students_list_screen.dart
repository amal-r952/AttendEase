import 'package:attendance_tracker/src/models/student.dart';
import 'package:attendance_tracker/src/screens/mark_attendance_screen.dart';
import 'package:attendance_tracker/src/screens/upload_students_list_screen.dart';
import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:attendance_tracker/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widgets/build_custom_appbar_widget.dart';

class ViewStudentsListScreen extends StatefulWidget {
  const ViewStudentsListScreen({Key? key}) : super(key: key);

  @override
  State<ViewStudentsListScreen> createState() => _ViewStudentsListScreenState();
}

class _ViewStudentsListScreenState extends State<ViewStudentsListScreen> {
  late Box<Student> studentsBox;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    studentsBox = Hive.box<Student>('studentsBox');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildCustomAppBarWidget(
        title: "Students",
        showBackButton: false,
        showTrailingIcon: true,
        trailingIcon: const Icon(Icons.person),
        trailingIconSize: 30,
        onTrailingIconPressed: () {
          push(context, const UploadStudentsListScreen()).then((_) {
            setState(() {});
          });
        },
      ),
      body: studentsBox.isEmpty
          ? Center(
              child: Text(
              "No students found.",
              style: Theme.of(context).textTheme.bodyLarge,
            ))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
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
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Name",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Roll No",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Course",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: studentsBox.length,
                      itemBuilder: (context, index) {
                        final student = studentsBox.getAt(index);
                        return Card(
                          margin: const EdgeInsets.all(3),
                          color: Theme.of(context).cardColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    student!.studentId.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    student.studentName,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    student.rollNumber.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    student.courseName,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          push(context, const MarkAttendanceScreen());
        },
        backgroundColor: AppColors.primaryColorOrange,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
