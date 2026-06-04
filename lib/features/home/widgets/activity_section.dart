import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../activity/repositories/activity_repository.dart';
import 'activity_title.dart';
import 'section_header.dart';

class ActivitySection extends StatelessWidget {
  final VoidCallback onViewAll;

  const ActivitySection({super.key, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ActivityRepository.instance,
      builder: (context, _) {
        final repo = ActivityRepository.instance;
        final activities = repo.recent(3);
        final showViewAll = repo.hasMoreThan3;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Recent Activity',
              trailing: showViewAll ? _ViewAllButton(onTap: onViewAll) : null,
            ),
            const SizedBox(height: 14),
            if (activities.isEmpty)
              const _EmptyCard()
            else
              ...activities.map(
                (a) => ActivityTile(key: ValueKey(a.id), activity: a),
              ),
          ],
        );
      },
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Text(
        'Belum ada aktivitas.',
        textAlign: TextAlign.center,
        style: AppTextStyles.emptyState,
      ),
    );
  }
}

class _ViewAllButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ViewAllButton({required this.onTap});

  @override
  State<_ViewAllButton> createState() => _ViewAllButtonState();
}

class _ViewAllButtonState extends State<_ViewAllButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _pressed ? AppColors.border : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('View All', style: AppTextStyles.sectionAction),
              const SizedBox(width: 2),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}