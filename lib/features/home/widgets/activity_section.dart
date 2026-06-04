// lib/features/home/widgets/activity_section.dart
import 'package:flutter/material.dart';

class ActivitySection extends StatelessWidget {
  final VoidCallback onViewAll;
  final ScrollController scrollController;

  const ActivitySection({
    super.key,
    required this.onViewAll,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    // Simulasi data aktivitas boss (Nanti tinggal diganti pakai data dari Controller / API)
    // Karena kita mau yang terbaru di atas, datanya kita balik pakai .reversed
    final List<Map<String, dynamic>> dummyActivities = [
      {
        'title': 'Tugas diselesaikan',
        'subtitle': 'hi',
        'time': '3j',
        'icon': Icons.check_circle_outline,
        'iconColor': Colors.green,
        'bgColor': Colors.green.withOpacity(0.1),
      },
      {
        'title': 'Tugas baru ditambahkan',
        'subtitle': 'hi',
        'time': '1j',
        'icon': Icons.add_task,
        'iconColor': Colors.blue,
        'bgColor': Colors.blue.withOpacity(0.1),
      },
      {
        'title': 'Tugas dihapus',
        'subtitle': 'hi',
        'time': '1m',
        'icon': Icons.delete_outline,
        'iconColor': Colors.red,
        'bgColor': Colors.red.withOpacity(0.1),
      },
    ].reversed.toList(); // <-- INI KUNCI BIAR YANG BARU (1m) MUNCUL DI ATAS BOSS!

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- HEADER ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity', 
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)
            ),
            GestureDetector(
              onTap: onViewAll,
              child: const Text(
                'View All >', 
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 13)
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // --- LIST VIEW ANTI OVERFLOW ---
        Expanded( 
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            thickness: 4.0,
            radius: const Radius.circular(8),
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: dummyActivities.length, 
              itemBuilder: (context, index) {
                final activity = dummyActivities[index];
                
                return _ActivityTile(
                  title: activity['title'],
                  subtitle: activity['subtitle'],
                  time: activity['time'],
                  icon: activity['icon'],
                  iconColor: activity['iconColor'],
                  bgColor: activity['bgColor'],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// --- WIDGET UI REKONSTRUKSI DARI SCREENSHOT BOSS ---
class _ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1E1E1E)),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}