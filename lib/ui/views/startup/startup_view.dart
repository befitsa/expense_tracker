import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_colors.dart';
import '../../common/app_icons.dart';
import '../../common/app_strings.dart';
import '../../common/app_text_styles.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(gradient: AppColors.kcGradientPrimary),
    child:  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            AppIcons.kiWallet,
            size: 40,
            color: AppColors.kcTextOnDark,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppStrings.ksAppName,
          style: AppTextStyles.ktsHeading1.copyWith(color: AppColors.kcTextOnDark),
        ),
        const SizedBox(height: 32),
        const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation(AppColors.kcBackground),
          ),
        )
      ],
      ),
    ),
    ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  @override
  void onViewModelReady(StartupViewModel viewModel) =>
      viewModel.runStartupLogic();
}
