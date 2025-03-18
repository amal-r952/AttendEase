import 'package:attendance_tracker/src/screens/view_students_list_screen.dart';
import 'package:attendance_tracker/src/theme/app_theme/app_theme_data.dart';
import 'package:attendance_tracker/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.bottomNavigationBg,
      ),
    );
    return MaterialApp(
      title: 'AttendEase',
      darkTheme: AppThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme,
      themeMode: ThemeMode.system,
      home: ViewStudentsListScreen(),
    );
  }
}
