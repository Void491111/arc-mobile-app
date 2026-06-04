import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/home_controller.dart';

class StatusCard extends StatelessWidget {
  final SystemStatus systemStatus;
  final String machineLabel;
  final DateTime now;
  final Duration uptime;

  const StatusCard({
    super.key,
    required this.systemStatus,
    required this.machineLabel,
    required this.now,
    required this.uptime,
  });

  String _formatTime(DateTime dt) => DateFormat('HH:mm:ss').format(dt);

  String _formatDate(DateTime dt) => DateFormat('EEEE, d MMM y').format(dt);

  String _formatUptime(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = systemStatus == SystemStatus.online;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.statusRedStart, AppColors.statusRedEnd],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.statusRedStart.withValues(alpha: 0.35),
            blurRadius: 32,
            offset: const Offset(0, 12),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StatusPill(isOnline: isOnline),
                const Spacer(),
                Text(_formatDate(now), style: AppTextStyles.statusDate),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Machine State', style: AppTextStyles.statusLabel),
                      const SizedBox(height: 4),
                      Text(machineLabel, style: AppTextStyles.statusValue),
                    ],
                  ),
                ),
                Text(_formatTime(now), style: AppTextStyles.statusClock),
              ],
            ),
            const SizedBox(height: 16),
            Divider(
              color: Colors.white.withValues(alpha: 0.25),
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text('Session Uptime: ', style: AppTextStyles.statusUptimeLabel),
                Text(_formatUptime(uptime),
                    style: AppTextStyles.statusUptimeValue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final bool isOnline;
  const _StatusPill({required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.statusPillBg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isOnline ? AppColors.statusDot : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            isOnline ? 'SYSTEM ONLINE' : 'SYSTEM OFFLINE',
            style: AppTextStyles.statusPill,
          ),
        ],
      ),
    );
  }
}