import 'package:flutter/material.dart';
import '../../../services/expense_service.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class SortDropdown extends StatelessWidget {
  final SortOption selected;
  final ValueChanged<SortOption> onChanged;

  const SortDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  String _kfLabel(SortOption option) {
    switch (option) {
      case SortOption.newest:
        return AppStrings.ksSortNewest;
      case SortOption.oldest:
        return AppStrings.ksSortOldest;
      case SortOption.highest:
        return AppStrings.ksSortHighest;
      case SortOption.lowest:
        return AppStrings.ksSortLowest;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UiHelpers.ksp12),
      decoration: BoxDecoration(
        color: AppColors.kcSurface,
        borderRadius: BorderRadius.circular(UiHelpers.krad16),
        border: Border.all(color: AppColors.kcBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SortOption>(
          value: selected,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.kcTextSecondary),
          style: AppTextStyles.ktsBodySmall.copyWith(
            color: AppColors.kcTextPrimary,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          items: SortOption.values.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(_kfLabel(option)),
            );
          }).toList(),
        ),
      ),
    );
  }
}