import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor = AppColors.kcPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(UiHelpers.ksp16),
        decoration: BoxDecoration(
          color: AppColors.kcSurface,
          borderRadius: BorderRadius.circular(UiHelpers.krad20),
          boxShadow: UiHelpers.kdCardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(UiHelpers.krad12),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(height: UiHelpers.ksp12),
            Text(value, style: AppTextStyles.ktsAmountMedium),
            const SizedBox(height: UiHelpers.ksp4),
            Text(label, style: AppTextStyles.ktsBodySmall),
          ],
        ),
      ),
    );
  }
}
