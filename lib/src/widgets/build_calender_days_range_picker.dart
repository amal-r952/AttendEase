import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'build_elevated_button.dart';

class BuildCalenderDaysRangePicker extends StatefulWidget {
  final Function(DateTimeRange) onRangeSelected;

  const BuildCalenderDaysRangePicker({
    super.key,
    required this.onRangeSelected,
  });

  @override
  State<BuildCalenderDaysRangePicker> createState() =>
      _BuildCalenderDaysRangePickerState();
}

class _BuildCalenderDaysRangePickerState
    extends State<BuildCalenderDaysRangePicker> {
  DateTimeRange? dateTimeRange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Choose the dates',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: RangeDatePicker(
            selectedCellsDecoration: BoxDecoration(
              color: AppColors.primaryColorOrange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            selectedCellsTextStyle: TextStyle(
              color: AppColors.primaryColorOrange.withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
            singleSelectedCellDecoration: const BoxDecoration(
              color: AppColors.primaryColorOrange,
              shape: BoxShape.circle,
            ),
            singleSelectedCellTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            currentDateDecoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColorOrange.withOpacity(0.3),
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            currentDateTextStyle: TextStyle(
              color: AppColors.primaryColorOrange.withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
            daysOfTheWeekTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.primaryColorOrange),
            disabledCellsTextStyle: Theme.of(context).textTheme.bodySmall,
            enabledCellsTextStyle: Theme.of(context).textTheme.bodyMedium,
            leadingDateTextStyle: Theme.of(context).textTheme.headlineMedium,
            initialPickerType: PickerType.days,
            slidersColor: AppColors.primaryColorOrange,
            highlightColor: AppColors.primaryColorOrange.withOpacity(0.1),
            slidersSize: 20,
            splashColor: AppColors.primaryColorOrange.withOpacity(0.2),
            centerLeadingDate: true,
            minDate: DateTime(2025, 1, 1),
            maxDate: DateTime.now(),
            onRangeSelected: (value) {
              setState(() {
                dateTimeRange = value;
              });
            },
          ),
        ),
        if (dateTimeRange != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              dateTimeRange!.start == dateTimeRange!.end
                  ? formatDate(dateTimeRange!.start)
                  : "${formatDate(dateTimeRange!.start)} to ${formatDate(dateTimeRange!.end)}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Double tap to choose a particular day!",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: BuildElevatedButton(
            backgroundColor: dateTimeRange != null
                ? AppColors.primaryColorOrange
                : AppColors.elevatedButtonHintColorLight,
            onTap: dateTimeRange != null
                ? () async {
                    widget.onRangeSelected(dateTimeRange!);
                    pop(context);
                  }
                : null,
            txt: "Done",
            child: null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: TextButton(
            onPressed: () {
              pop(context);
            },
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
