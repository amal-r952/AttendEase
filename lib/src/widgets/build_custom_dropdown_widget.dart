import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:attendance_tracker/src/utils/font_family.dart';
import 'package:flutter/material.dart';

class BuildCustomDropdownWidget extends StatefulWidget {
  final List<String> dropDownItems;
  final Function onChanged;
  final double? upArrowSize;
  final double? downArrowSize;
  final TextStyle? listItemStyle;
  final TextStyle? headerItemStyle;
  final TextStyle? hintStyle;
  final String? initialItem;

  const BuildCustomDropdownWidget({
    super.key,
    required this.dropDownItems,
    required this.onChanged,
    this.upArrowSize,
    this.downArrowSize,
    this.listItemStyle,
    this.headerItemStyle,
    this.hintStyle,
    this.initialItem,
  });

  @override
  State<BuildCustomDropdownWidget> createState() =>
      _BuildCustomDropdownWidgetState();
}

class _BuildCustomDropdownWidgetState extends State<BuildCustomDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      decoration: CustomDropdownDecoration(
        closedFillColor: Theme.of(context).cardColor,
        expandedFillColor: Theme.of(context).cardColor,
        closedSuffixIcon: Icon(
          Icons.keyboard_arrow_down,
          size: widget.downArrowSize ?? 30,
          color: Theme.of(context).dividerColor,
        ),
        expandedSuffixIcon: Icon(
          Icons.keyboard_arrow_up,
          size: widget.upArrowSize ?? 30,
          color: Theme.of(context).dividerColor,
        ),
        closedBorderRadius: BorderRadius.circular(12),
        expandedBorderRadius: BorderRadius.circular(12),
        listItemStyle: widget.listItemStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).dividerColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.gothamBook,
                ),
        hintStyle: widget.hintStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).dividerColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.gothamBook,
                ),
        headerStyle: widget.headerItemStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).dividerColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.gothamBook,
                ),
        listItemDecoration: ListItemDecoration(
          selectedColor: Theme.of(context).cardColor.withOpacity(0.5),
          highlightColor: Theme.of(context).cardColor.withOpacity(0.5),
        ),
      ),
      canCloseOutsideBounds: true,
      closedHeaderPadding: const EdgeInsets.all(12),
      items: widget.dropDownItems,
      initialItem: widget.initialItem ?? widget.dropDownItems[0],
      excludeSelected: true,
      onChanged: (value) {
        print('SELECTED: $value');
        widget.onChanged(value);
      },
    );
  }
}
