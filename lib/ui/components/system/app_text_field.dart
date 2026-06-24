import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;
  final int maxLines;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixWidget,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.ktsLabel),
        const SizedBox(height: UiHelpers.ksp8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          style: AppTextStyles.ktsBodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.ktsBodyLarge
                .copyWith(color: AppColors.kcTextSecondary),
            filled: true,
            fillColor: AppColors.kcSurface,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.kcTextSecondary, size: 20)
                : null,
            suffixIcon: suffixWidget,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: UiHelpers.ksp16,
              vertical: UiHelpers.ksp16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UiHelpers.krad16),
              borderSide: BorderSide(
                color: hasError ? AppColors.kcError : AppColors.kcBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UiHelpers.krad16),
              borderSide: BorderSide(
                color: hasError ? AppColors.kcError : AppColors.kcBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UiHelpers.krad16),
              borderSide: BorderSide(
                color: hasError ? AppColors.kcError : AppColors.kcPrimary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UiHelpers.krad16),
              borderSide: const BorderSide(color: AppColors.kcError),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: UiHelpers.ksp4),
          Text(
            errorText!,
            style: AppTextStyles.ktsCaption
                .copyWith(color: AppColors.kcError),
          ),
        ],
      ],
    );
  }
}