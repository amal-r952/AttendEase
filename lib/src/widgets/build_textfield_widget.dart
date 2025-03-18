import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import '../utils/font_family.dart';

class BuildTextField extends StatelessWidget {
  final TextCapitalization? textCapitalization;
  final bool? showCounterText;
  final double? bottomRight;
  final double? bottomLeft;
  final double? topRight;
  final double? topLeft;
  final int? borderRadiusStyle;
  final String? labelText;
  final String? hintText;
  final Color? labelColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final Color? fillColor;
  final double? borderRadius;
  final double? cursorHeight;
  final double? hintTextSize;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? label;
  final Function(String? value)? validation;
  final bool showAlwaysErrorBorder;
  final bool? filled;
  final bool? isDense;
  final bool showBorder;
  final bool? readOnly;
  final bool? obscureText;
  final bool? enable;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController textEditingController;
  final Function? onTap;
  final FocusNode? focusNode;
  final Widget? suffixWidget;

  BuildTextField({
    Key? key,
    this.labelText,
    this.borderRadiusStyle,
    this.bottomRight,
    this.topRight,
    this.topLeft,
    this.bottomLeft,
    this.enable,
    this.hintText,
    this.suffixWidget,
    this.focusNode,
    this.labelColor,
    this.hintColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.borderRadius,
    this.cursorHeight,
    this.maxLines,
    this.cursorColor,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly,
    this.fillColor,
    this.validation,
    this.onTap,
    this.filled,
    this.keyboardType,
    this.label,
    required this.textEditingController,
    this.prefix,
    this.isDense,
    this.hintTextSize,
    this.minLines,
    required this.showBorder,
    this.inputFormatters,
    this.maxLength,
    this.obscureText,
    required this.showAlwaysErrorBorder,
    this.showCounterText,
    this.textCapitalization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: AppColors.primaryColorLight,
          selectionHandleColor: AppColors.primaryColorDark,
        ),
      ),
      child: TextFormField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        textInputAction: TextInputAction.done,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        enabled: enable,
        focusNode: focusNode,
        onTap: () {
          readOnly == true ? onTap!() : () {};
        },
        obscureText: obscureText ?? false,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: textColor ?? Theme.of(context).dividerColor,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.gothamBook,
            ),
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        controller: textEditingController,
        validator: (value) => validation!(value),
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        readOnly: readOnly ?? false,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor ?? AppColors.primaryColorDark,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
            borderSide: const BorderSide(
              // color: AppColors.authScreensTextFieldBorderColour,
              color: Colors.transparent,
            ),
          ),
          counterStyle: const TextStyle(
            height: double.minPositive,
          ),
          counterText: showCounterText == true ? null : "",
          errorStyle: TextStyle(
            color: errorBorderColor ??
                AppColors.primaryColorOrange.withOpacity(0.7),
            fontWeight: FontWeight.w300,
            fontFamily: FontFamily.gothamBook,
            fontSize: 11,
          ),
          floatingLabelStyle: TextStyle(
            color: labelColor ?? Colors.black,
            fontFamily: FontFamily.gothamBook,
            fontWeight: FontWeight.w400,
          ),
          isDense: isDense,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffix: suffixWidget,
          prefix: prefix,
          alignLabelWithHint: true,
          filled: filled ?? true,
          fillColor: fillColor ?? AppColors.textFieldFillColour,
          labelText: labelText,
          label: label,
          labelStyle: TextStyle(
            color: labelColor,
            fontFamily: FontFamily.gothamBook,
            fontWeight: FontWeight.w400,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: hintColor ?? AppColors.textFieldHintColor,
              fontSize: hintTextSize ?? 12,
              fontFamily: FontFamily.gothamBook),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            borderSide: BorderSide(
              color: showAlwaysErrorBorder
                  ? (errorBorderColor ?? AppColors.primaryColorOrange)
                  : Colors.transparent,
            ),
            gapPadding: 0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            borderSide: BorderSide(
              color: showAlwaysErrorBorder
                  ? (errorBorderColor ?? AppColors.primaryColorOrange)
                  : Colors.transparent,
            ),
            gapPadding: 0,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            borderSide: BorderSide(
              color: showAlwaysErrorBorder
                  ? (errorBorderColor ?? AppColors.primaryColorOrange)
                  : Colors.transparent,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            borderSide: BorderSide(
              color: showAlwaysErrorBorder
                  ? (errorBorderColor ?? AppColors.primaryColorOrange)
                  : Colors.transparent,
            ),
            gapPadding: 0,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            borderSide: const BorderSide(color: Colors.transparent),
            gapPadding: 0,
          ),
        ),
      ),
    );
  }
}
