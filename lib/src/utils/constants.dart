import 'package:flutter/material.dart';

class Constants {
  static final rupeeSymbol = "\u20B9";
  static const String BOX_NAME = "attendance_tracker";

  ///gradients
  static List<Color> kitGradients = [
    Colors.white, //0
    Color(0xFFA38E5D),
    Colors.green,
    Colors.red,
  ];

  static List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Health",
    "Entertainment",
    "Others",
  ];

  static List<String> currencies = [
    "INR - Indian Rupee",
    "USD - United States Dollar",
    "EUR - Euro",
    "GBP - British Pound Sterling",
    "JPY - Japanese Yen",
    "AUD - Australian Dollar",
    "CAD - Canadian Dollar",
    "CHF - Swiss Franc",
    "CNY - Chinese Yuan Renminbi",
    "SGD - Singapore Dollar"
  ];

  ///API Keys
  static const String placesSearchAPIKey = "";
  static const String currencyApiKey =
      "fca_live_QsUFEaUEkEbeDHfFhc8Mkpk6OruuCleVLWafc8uZ";
  static const supabaseUrl = 'https://bnbsxstdgnypjnvsxack.supabase.co';
  static const supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJuYnN4c3RkZ255cGpudnN4YWNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEwMDIwODYsImV4cCI6MjA1NjU3ODA4Nn0.udbBhcn4rsD6_4Uza3QIPXy9O1uIexSvzLTyJm4TFYc";

  ///error
  static const String SOME_ERROR_OCCURRED = "Some error occurred.";

  ///dialog
  static const String CANCEL = "Cancel";
  static const String OK = "Ok";
  static const String YES = "Yes";
  static const String CLOSE = "Close";
  static const String UPDATE = "Update";

  ///no internet
  static const String NO_INTERNET_TEXT = "No Internet Connection !!!";
  static const String INTERNET_CONNECTED = "Internet Connected !!!";

  ///validators
  static const String EMAIL_NOT_VALID = "Email is not valid";
  static const String USERNAME_NOT_VALID = "Username is not valid";
  static const String PASSWORD_LENGTH =
      "Password length should be greater than 5 chars.";
  static const String INVALID_MOBILE_NUM = "Invalid mobile number";
  static const String INVALID_NAME = "Invalid name";
}
