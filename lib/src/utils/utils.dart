import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

Future<dynamic> push(BuildContext context, Widget route) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => route));
}

void pop(BuildContext context) {
  return Navigator.pop(context);
}

Future<dynamic> pushAndRemoveUntil(
    BuildContext context, Widget route, bool goBack) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => route), (route) => goBack);
}

Future<dynamic> pushAndReplacement(BuildContext context, Widget route) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => route));
}

lauchUrl({required String url}) async {
  await launch(url);
}

String formatTime(DateTime dateTime, {bool showTime = false}) {
  int day = dateTime.day;

  String suffix = "th";
  if (day % 10 == 1 && day != 11) {
    suffix = "st";
  } else if (day % 10 == 2 && day != 12) {
    suffix = "nd";
  } else if (day % 10 == 3 && day != 13) {
    suffix = "rd";
  }

  String formattedDate =
      "$day$suffix ${DateFormat('MMMM yyyy').format(dateTime)}";

  if (showTime) {
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    formattedDate += " $formattedTime";
  }

  return formattedDate;
}

Future<XFile?> pickImage() async {
  XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (result != null) {
    return result;
  } else {
    return null;
  }
}

double convertFromINR(double amountInINR, double conversionRate) {
  return amountInINR * conversionRate;
}

double convertToINR(double amount, double conversionRate) {
  if (conversionRate == 0) return 0.0;
  return amount / conversionRate;
}
