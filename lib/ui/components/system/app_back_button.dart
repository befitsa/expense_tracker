import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_icons.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLight;

  const AppBackButton({
    super.key,
    required this.onTap,
    this.isLight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isLight
                ? Colors.white.withValues(alpha: 0.15)
                : AppColors.kcSurface,
            shape: BoxShape.circle,
            border: isLight
                ? null
                : Border.all(color: AppColors.kcBorder),
          ),
          child: Icon(
            AppIcons.kiBack,
            size: 18,
            color: isLight ? Colors.white : AppColors.kcTextPrimary,
          ),
        ),
      ),
    );
  }
}