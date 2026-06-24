import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_icons.dart';

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;

  const CategoryItem({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CategoryConfig {
  CategoryConfig._();

  // ks = static const String (category name keys)
  static const String ksFood = 'Food';
  static const String ksTransport = 'Transport';
  static const String ksShopping = 'Shopping';
  static const String ksBills = 'Bills';
  static const String ksEntertainment = 'Entertainment';
  static const String ksHealth = 'Health';
  static const String ksEducation = 'Education';
  static const String ksOther = 'Other';

  static const List<CategoryItem> kdCategories = [
    CategoryItem(
        name: ksFood,
        icon: AppIcons.kiCategoryFood,
        color: Color(0xFFFF8A65)),
    CategoryItem(
        name: ksTransport,
        icon: AppIcons.kiCategoryTransport,
        color: Color(0xFF00BBF9)),
    CategoryItem(
        name: ksShopping,
        icon: AppIcons.kiCategoryShopping,
        color: Color(0xFFF15BB5)),
    CategoryItem(
        name: ksBills,
        icon: AppIcons.kiCategoryBills,
        color: Color(0xFFFFB020)),
    CategoryItem(
        name: ksEntertainment,
        icon: AppIcons.kiCategoryEntertainment,
        color: Color(0xFF9B5DE5)),
    CategoryItem(
        name: ksHealth,
        icon: AppIcons.kiCategoryHealth,
        color: Color(0xFFFF5A5F)),
    CategoryItem(
        name: ksEducation,
        icon: AppIcons.kiCategoryEducation,
        color: Color(0xFF38B000)),
    CategoryItem(
        name: ksOther,
        icon: AppIcons.kiCategoryOther,
        color: AppColors.kcTextSecondary),
  ];

  static CategoryItem kfGetCategory(String name) {
    return kdCategories.firstWhere(
      (c) => c.name == name,
      orElse: () => kdCategories.last,
    );
  }

  static List<String> get kdCategoryNames =>
      kdCategories.map((c) => c.name).toList();
}