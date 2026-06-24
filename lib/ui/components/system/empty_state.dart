import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_icons.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const EmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = AppIcons.kiEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: UiHelpers.ksp32 * 1.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.kcPrimary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 36, color: AppColors.kcPrimary),
          ),
          const SizedBox(height: UiHelpers.ksp20),
          Text(
            title,
            style: AppTextStyles.ktsHeading3,
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: UiHelpers.ksp8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: UiHelpers.ksp32),
              child: Text(
                subtitle!,
                style: AppTextStyles.ktsBodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}