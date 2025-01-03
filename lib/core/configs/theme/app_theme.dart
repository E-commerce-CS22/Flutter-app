import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {

  static const TextStyle blackTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Almarai',
  );


  static final appTheme = ThemeData(
    // primaryColor: AppColors.primary,
    primaryColor: const Color(0xff0052cc),
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.light,
    fontFamily: 'Almarai',
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.secondBackground,
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondBackground,
        labelStyle: const TextStyle(
        color: Color(0xff000000),
        fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          color: Color(0xff000000),
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none
        )
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700, fontFamily: 'Almarai'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        )
      )
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.primary, // Use primary color for CircularProgressIndicator
  ),
  );



}