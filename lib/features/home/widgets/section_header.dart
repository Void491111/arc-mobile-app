import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

/// Header reusable buat tiap section: title kiri + optional trailing widget kanan.
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.sectionTitle)),
        if (trailing != null) trailing!,
      ],
    );
  }
}