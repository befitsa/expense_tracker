import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import '../../common/category_config.dart';
import '../../common/ui_helpers.dart';
import '../home/dashboard_card.dart';

class CategoryAnalyticsCard extends StatelessWidget {
  final Map<String, double> breakdown;

  const CategoryAnalyticsCard({
    super.key,
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    final total = breakdown.values.fold(0.0, (a, b) => a + b);
    final sortedEntries = breakdown.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return DashboardCard(
      title: AppStrings.ksDashboardCategoryBreakdown,
      child: total == 0
          ? Text('No data yet', style: AppTextStyles.ktsBodySmall)
          : Column(
              children: sortedEntries.map((entry) {
                final category = CategoryConfig.kfGetCategory(entry.key);
                final percent = entry.value / total;

                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: UiHelpers.ksp12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: category.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: UiHelpers.ksp8),
                              Text(entry.key,
                                  style: AppTextStyles.ktsBodySmall
                                      .copyWith(
                                          fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Text(
                            UiHelpers.kfFormatCurrency(entry.value),
                            style: AppTextStyles.ktsBodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: UiHelpers.ksp8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(UiHelpers.krad12),
                        child: LinearProgressIndicator(
                          value: percent,
                          minHeight: 6,
                          backgroundColor: AppColors.kcBackground,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              category.color),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}