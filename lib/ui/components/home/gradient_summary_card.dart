import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_icons.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';

class GradientSummaryCard extends StatelessWidget {
  final String userName;
  final double totalSpent;
  final double monthlySpent;

  const GradientSummaryCard({
    super.key,
    required this.userName,
    required this.totalSpent,
    required this.monthlySpent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(UiHelpers.ksp24),
      decoration: BoxDecoration(
        gradient: AppColors.kcGradientPrimary,
        borderRadius: BorderRadius.circular(UiHelpers.krad24),
        boxShadow: UiHelpers.kdSoftShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.ksDashboardGreeting,
                    style: AppTextStyles.ktsOnDarkMuted,
                  ),
                  const SizedBox(height: UiHelpers.ksp4),
                  Text(
                    userName,
                    style: AppTextStyles.ktsHeading3
                        .copyWith(color: AppColors.kcTextOnDark),
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(AppIcons.kiWallet,
                    color: AppColors.kcTextOnDark, size: 20),
              ),
            ],
          ),
          const SizedBox(height: UiHelpers.ksp24),
          Text(
            AppStrings.ksDashboardTotalBalance,
            style: AppTextStyles.ktsOnDarkMuted,
          ),
          const SizedBox(height: UiHelpers.ksp4),
          Text(
            UiHelpers.kfFormatCurrency(totalSpent),
            style: AppTextStyles.ktsAmountLarge,
          ),
          const SizedBox(height: UiHelpers.ksp20),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: UiHelpers.ksp12,
              vertical: UiHelpers.ksp8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(UiHelpers.krad12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(AppIcons.kiTrendingUp,
                    size: 14, color: AppColors.kcTextOnDark),
                const SizedBox(width: UiHelpers.ksp4),
                Text(
                  '${AppStrings.ksDashboardThisMonth}: ${UiHelpers.kfFormatCurrency(monthlySpent)}',
                  style: AppTextStyles.ktsOnDarkMuted
                      .copyWith(color: AppColors.kcTextOnDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}