import 'package:flutter/material.dart';
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

  // Helper untuk format tanggal ala "Thursday, 4 Jun 2026" tanpa package tambahan
  String _formatDate(DateTime date) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Helper untuk format jam "22:50:05"
  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }

  // Helper untuk format uptime "00:00:00"
  String _formatDuration(Duration d) {
    return '${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // Logic ganti warna & teks berdasarkan status (Offline = Merah, Running = Hijau/Biru)
    final bool isOffline = systemStatus == SystemStatus.offline;
    final String statusText = isOffline ? 'SYSTEM OFFLINE' : 'SYSTEM ONLINE';
    final Color dotColor = isOffline
        ? Colors.grey.shade400
        : Colors.greenAccent;
    final List<Color> bgGradient = isOffline
        ? [const Color(0xFFE53935), const Color(0xFFC62828)] // Merah industri
        : [
            const Color(0xFF1E88E5),
            const Color(0xFF1565C0),
          ]; // Biru kalau lagi running

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: bgGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: bgGradient.last.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. TOP ROW: Status Pill & Date ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      statusText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _formatDate(now),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- 2. MIDDLE ROW: Machine State & Time ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Machine State',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    machineLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Text(
                _formatTime(now),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- 3. DIVIDER ---
          Divider(
            color: Colors.white.withOpacity(0.2),
            thickness: 1,
            height: 1,
          ),
          const SizedBox(height: 16),

          // --- 4. BOTTOM ROW: Uptime ---
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                color: Colors.white.withOpacity(0.9),
                size: 18,
              ),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                  children: [
                    const TextSpan(text: 'Session Uptime: '),
                    TextSpan(
                      text: _formatDuration(uptime),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
