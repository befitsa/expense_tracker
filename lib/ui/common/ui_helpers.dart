import 'dart:math';
import 'package:flutter/material.dart';
import 'app_colors.dart';

// ====================
// Default Stacked Helpers
// ====================

const double _tinySize = 5.0;
const double _smallSize = 10.0;
const double _mediumSize = 25.0;
const double _largeSize = 50.0;
const double _massiveSize = 120.0;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

Widget spacedDivider = const Column(
  children: [
    SizedBox(height: _mediumSize),
    Divider(color: Colors.blueGrey, height: 5.0),
    SizedBox(height: _mediumSize),
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

double screenHeightFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(
  BuildContext context, {
  int dividedBy = 1,
  double offsetBy = 0,
  double max = 3000,
}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);

double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 15);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(
  BuildContext context, {
  double? fontSize,
  double? max,
}) {
  max ??= 100;

  return min(
    screenWidthFraction(context, dividedBy: 10) *
        ((fontSize ?? 100) / 100),
    max,
  );
}


class UiHelpers {
  UiHelpers._();

  // Durations
  static const Duration kdurFast = Duration(milliseconds: 150);
  static const Duration kdurMedium = Duration(milliseconds: 300);
  static const Duration kdurSlow = Duration(milliseconds: 500);

  // Spacing Scale
  static const double ksp4 = 4;
  static const double ksp8 = 8;
  static const double ksp12 = 12;
  static const double ksp16 = 16;
  static const double ksp20 = 20;
  static const double ksp24 = 24;
  static const double ksp32 = 32;

  // Radius Scale
  static const double krad12 = 12;
  static const double krad16 = 16;
  static const double krad20 = 20;
  static const double krad24 = 24;

  // Currency Formatter
  static String kfFormatCurrency(double amount) {
    return 'ETB ${amount.toStringAsFixed(2)}';
  }

  // Date Formatter
  static String kfFormatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  static String kfFormatDateShort(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${months[date.month - 1]} ${date.day}';
  }

  // Shadows
  static List<BoxShadow> kdSoftShadow = [
    const BoxShadow(
      color: AppColors.kcShadow,
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  static List<BoxShadow> kdCardShadow = [
    const BoxShadow(
      color: AppColors.kcShadow,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  // Date Utilities
  static bool kfIsSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }
}