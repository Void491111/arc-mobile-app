import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../activity/models/activity_model.dart';

class ActivityTile extends StatelessWidget {
  final ActivityModel activity;

  const ActivityTile({super.key, required this.activity});

  IconData _iconFor(ActivityType type) {
    switch (type) {
      case ActivityType.todoAdded:
        return Icons.add_task_rounded;
      case ActivityType.todoCompleted:
        return Icons.check_circle_outline_rounded;
      case ActivityType.todoUncompleted:
        return Icons.radio_button_unchecked_rounded;
      case ActivityType.todoRemoved:
        return Icons.delete_outline_rounded;
      case ActivityType.machineStateChanged:
        return Icons.settings_input_component_rounded;
      case ActivityType.systemEvent:
        return Icons.info_outline_rounded;
    }
  }

  Color _colorFor(ActivityType type) {
    switch (type) {
      case ActivityType.todoAdded:
        return AppColors.accentBlue;
      case ActivityType.todoCompleted:
        return Colors.green.shade600;
      case ActivityType.todoUncompleted:
        return AppColors.textSecondary;
      case ActivityType.todoRemoved:
        return AppColors.accentRed;
      case ActivityType.machineStateChanged:
        return AppColors.accentPurple;
      case ActivityType.systemEvent:
        return AppColors.textSecondary;
    }
  }

  String _timeAgo(DateTime ts) {
    final diff = DateTime.now().difference(ts);
    if (diff.inMinutes < 1) return 'baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}j';
    if (diff.inDays < 7) return '${diff.inDays}h';
    return DateFormat('d MMM').format(ts);
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(activity.type);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_iconFor(activity.type), color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  activity.title,
                  style: AppTextStyles.todoTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (activity.description != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    activity.description!,
                    style: AppTextStyles.emptyState.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _timeAgo(activity.timestamp),
            style: AppTextStyles.emptyState.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}