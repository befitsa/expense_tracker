import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // kts = static const TextStyle
  static const TextStyle ktsHeading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.kcTextPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle ktsHeading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.kcTextPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle ktsHeading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.kcTextPrimary,
  );

  static const TextStyle ktsBodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.kcTextPrimary,
  );

  static const TextStyle ktsBodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.kcTextPrimary,
  );

  static const TextStyle ktsBodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.kcTextSecondary,
  );

  static const TextStyle ktsLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.kcTextSecondary,
  );

  static const TextStyle ktsButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.kcTextOnDark,
  );

  static const TextStyle ktsAmountLarge = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.kcTextOnDark,
    letterSpacing: -1,
  );

  static const TextStyle ktsAmountMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.kcTextPrimary,
  );

  static const TextStyle ktsAmountSmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.kcTextPrimary,
  );

  static const TextStyle ktsOnDarkMuted = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.kcTextOnDarkMuted,
  );

  static const TextStyle ktsCaption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.kcTextSecondary,
  );
}