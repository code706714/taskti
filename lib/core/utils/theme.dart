import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_fonts.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: AppFonts.poppinsFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),
    datePickerTheme: DatePickerThemeData(backgroundColor: AppColors.whiteColor),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.whiteColor,
      dialBackgroundColor: AppColors.whiteColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.bodyStyle(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
    ),
  );

  static get darkTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.darkColor,
    fontFamily: AppFonts.poppinsFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.whiteColor,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.darkColor,
      headerForegroundColor: AppColors.primaryColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.darkColor,
      dialBackgroundColor: AppColors.darkColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.bodyStyle(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.redColor),
      ),
    ),
  );
}
