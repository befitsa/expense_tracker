import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class DashboardCard extends StatelessWidget {
  final String? title;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const DashboardCard({
    super.key,
    required this.child,
    this.title,
    this.actionLabel,
    this.onActionTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(UiHelpers.ksp16),
      decoration: BoxDecoration(
        color: AppColors.kcSurface,
        borderRadius: BorderRadius.circular(UiHelpers.krad20),
        boxShadow: UiHelpers.kdCardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!, style: AppTextStyles.ktsHeading3),
                if (actionLabel != null)
                  GestureDetector(
                    onTap: onActionTap,
                    child: Text(
                      actionLabel!,
                      style: AppTextStyles.ktsLabel
                          .copyWith(color: AppColors.kcPrimary),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: UiHelpers.ksp16),
          ],
          child,
        ],
      ),
    );
  }
}