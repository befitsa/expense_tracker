import 'package:flutter/material.dart';
import '../../common/category_config.dart';
import '../../common/app_strings.dart';
import '../../common/ui_helpers.dart';
import 'category_chip.dart';

class FilterChipsRow extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const FilterChipsRow({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      AppStrings.ksFilterAll,
      ...CategoryConfig.kdCategoryNames,
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: UiHelpers.ksp8),
        itemBuilder: (context, index) {
          final name = categories[index];
          final isAll = name == AppStrings.ksFilterAll;
          final categoryItem =
              isAll ? null : CategoryConfig.kfGetCategory(name);

          return CategoryChip(
            label: name,
            icon: categoryItem?.icon,
            selectedColor: categoryItem?.color,
            isSelected: selectedCategory == name,
            onTap: () => onCategorySelected(name),
          );
        },
      ),
    );
  }
}