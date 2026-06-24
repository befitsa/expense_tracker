import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_icons.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';
import '../home/dashboard_card.dart';

class MonthlySummaryCard extends StatelessWidget {
  final double currentMonthTotal;
  final double previousMonthTotal;

  const MonthlySummaryCard({
    super.key,
    required this.currentMonthTotal,
    this.previousMonthTotal = 0,
  });

  @override
  Widget build(BuildContext context) {
    final double diff = currentMonthTotal - previousMonthTotal;
    final bool isUp = diff > 0;
    final double percentChange =
        previousMonthTotal == 0 ? 0 : (diff / previousMonthTotal * 100);

    return DashboardCard(
      title: AppStrings.ksDashboardMonthlySummary,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UiHelpers.kfFormatCurrency(currentMonthTotal),
                  style: AppTextStyles.ktsAmountMedium,
                ),
                const SizedBox(height: UiHelpers.ksp4),
                Text('Total this month', style: AppTextStyles.ktsBodySmall),
              ],
            ),
          ),
          if (previousMonthTotal > 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: UiHelpers.ksp12,
                vertical: UiHelpers.ksp8,
              ),
              decoration: BoxDecoration(
                color: (isUp ? AppColors.kcError : AppColors.kcSuccess)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(UiHelpers.krad12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isUp ? AppIcons.kiTrendingUp : AppIcons.kiTrendingDown,
                    size: 14,
                    color: isUp ? AppColors.kcError : AppColors.kcSuccess,
                  ),
                  const SizedBox(width: UiHelpers.ksp4),
                  Text(
                    '${percentChange.abs().toStringAsFixed(0)}%',
                    style: AppTextStyles.ktsCaption.copyWith(
                      color: isUp ? AppColors.kcError : AppColors.kcSuccess,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
