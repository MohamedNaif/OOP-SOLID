import 'package:flutter/material.dart';
import 'package:solid_and_oop/config/theme/app_colors.dart';

class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}