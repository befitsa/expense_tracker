import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? selectedColor;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = selectedColor ?? AppColors.kcPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UiHelpers.krad20),
        child: AnimatedContainer(
          duration: UiHelpers.kdurFast,
          padding: const EdgeInsets.symmetric(
            horizontal: UiHelpers.ksp16,
            vertical: UiHelpers.ksp8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : AppColors.kcSurface,
            borderRadius: BorderRadius.circular(UiHelpers.krad20),
            border: Border.all(
              color: isSelected ? activeColor : AppColors.kcBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: isSelected
                      ? AppColors.kcTextOnDark
                      : AppColors.kcTextSecondary,
                ),
                const SizedBox(width: UiHelpers.ksp4),
              ],
              Text(
                label,
                style: AppTextStyles.ktsBodySmall.copyWith(
                  color: isSelected
                      ? AppColors.kcTextOnDark
                      : AppColors.kcTextSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}