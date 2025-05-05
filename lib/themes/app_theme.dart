import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.accent,
    background: AppColors.background,
    onBackground: AppColors.text,
    onPrimary: Colors.black,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.black,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: AppColors.text),
  ),
  cardTheme: CardTheme(
    color: Colors.grey[900],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);
