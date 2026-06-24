import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

enum AppButtonVariant { primary, secondary, outline, danger }

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null || isLoading;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 54,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : onTap,
          borderRadius: BorderRadius.circular(UiHelpers.krad16),
          child: Container(
            decoration: _kfDecoration(),
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 20, color: _kfTextColor()),
                        const SizedBox(width: UiHelpers.ksp8),
                      ],
                      Text(
                        title,
                        style: AppTextStyles.ktsButton
                            .copyWith(color: _kfTextColor()),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _kfDecoration() {
    switch (variant) {
      case AppButtonVariant.primary:
        return BoxDecoration(
          gradient: AppColors.kcGradientPrimary,
          borderRadius: BorderRadius.circular(UiHelpers.krad16),
          boxShadow: onTap == null ? null : UiHelpers.kdCardShadow,
        );
      case AppButtonVariant.secondary:
        return BoxDecoration(
          color: AppColors.kcSurface,
          borderRadius: BorderRadius.circular(UiHelpers.krad16),
          border: Border.all(color: AppColors.kcBorder),
        );
      case AppButtonVariant.outline:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(UiHelpers.krad16),
          border: Border.all(color: AppColors.kcPrimary, width: 1.5),
        );
      case AppButtonVariant.danger:
        return BoxDecoration(
          color: AppColors.kcError,
          borderRadius: BorderRadius.circular(UiHelpers.krad16),
          boxShadow: onTap == null ? null : UiHelpers.kdCardShadow,
        );
    }
  }

  Color _kfTextColor() {
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.danger:
        return AppColors.kcTextOnDark;
      case AppButtonVariant.secondary:
        return AppColors.kcTextPrimary;
      case AppButtonVariant.outline:
        return AppColors.kcPrimary;
    }
  }
}