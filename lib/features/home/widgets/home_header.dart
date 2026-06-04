import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  final String greeting;
  final String operatorName;
  final VoidCallback onSettingsTap;

  const HomeHeader({
    super.key,
    required this.greeting,
    required this.operatorName,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting, style: AppTextStyles.greeting),
              const SizedBox(height: 2),
              Text(operatorName, style: AppTextStyles.pageTitle),
            ],
          ),
        ),
        IconButton(
          onPressed: onSettingsTap,
          icon: const Icon(
            Icons.settings_rounded,
            color: AppColors.textSecondary,
            size: 26,
          ),
          splashRadius: 22,
        ),
      ],
    );
  }
}