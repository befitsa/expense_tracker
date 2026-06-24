import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_icons.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? hint;

  const AppSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: UiHelpers.ksp16),
      decoration: BoxDecoration(
        color: AppColors.kcSurface,
        borderRadius: BorderRadius.circular(UiHelpers.krad16),
        boxShadow: UiHelpers.kdCardShadow,
      ),
      child: Row(
        children: [
          const Icon(AppIcons.kiSearch,
              size: 20, color: AppColors.kcTextSecondary),
          const SizedBox(width: UiHelpers.ksp12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.ktsBodyMedium,
              decoration: InputDecoration(
                hintText: hint ?? AppStrings.ksExpenseListSearchHint,
                hintStyle: AppTextStyles.ktsBodyMedium
                    .copyWith(color: AppColors.kcTextSecondary),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            InkWell(
              onTap: () {
                controller.clear();
                onChanged?.call('');
              },
              child: const Icon(AppIcons.kiClose,
                  size: 18, color: AppColors.kcTextSecondary),
            ),
        ],
      ),
    );
  }
}