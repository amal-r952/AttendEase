import 'dart:core';

import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:attendance_tracker/src/utils/utils.dart';
import 'package:attendance_tracker/src/widgets/build_elevated_button.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';

class BuildSingleDayPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;

  const BuildSingleDayPicker({
    Key? key,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
  }) : super(key: key);

  @override
  _BuildSingleDayPickerState createState() => _BuildSingleDayPickerState();
}

class _BuildSingleDayPickerState extends State<BuildSingleDayPicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context, dividedBy: 2.5), // Adjust height
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Choose a date',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Expanded(
            child: DatePicker(
              initialDate: selectedDate,
              minDate: widget.minDate,
              maxDate: widget.maxDate,
              currentDate: DateTime.now(),
              selectedDate: selectedDate,
              selectedCellTextStyle: Theme.of(context).textTheme.bodyLarge,
              currentDateDecoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColorOrange.withOpacity(0.3),
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              selectedCellDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColorOrange,
              ),
              currentDateTextStyle: Theme.of(context).textTheme.bodyLarge,
              daysOfTheWeekTextStyle:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
              disabledCellsTextStyle: Theme.of(context).textTheme.bodySmall,
              enabledCellsTextStyle: Theme.of(context).textTheme.bodyMedium,
              leadingDateTextStyle: Theme.of(context).textTheme.headlineMedium,
              initialPickerType: PickerType.days,
              slidersColor: AppColors.primaryColorOrange,
              highlightColor: AppColors.primaryColorOrange.withOpacity(0.1),
              slidersSize: 20,
              splashColor: AppColors.primaryColorOrange.withOpacity(0.2),
              centerLeadingDate: true,
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: BuildElevatedButton(
              backgroundColor: AppColors.primaryColorOrange,
              height: screenHeight(context, dividedBy: 22),
              child: null,
              txt: "Done",
              onTap: () {
                Navigator.pop(context, selectedDate);
              },
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
