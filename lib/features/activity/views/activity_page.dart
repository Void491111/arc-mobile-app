import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../home/widgets/activity_title.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

enum ActivitySort { newest, oldest }

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  ActivitySort _sort = ActivitySort.newest;

  List<ActivityModel> _sorted(List<ActivityModel> items) {
    final list = [...items];
    list.sort((a, b) => _sort == ActivitySort.newest
        ? b.timestamp.compareTo(a.timestamp)
        : a.timestamp.compareTo(b.timestamp));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Activity Log',
          style: AppTextStyles.pageTitle.copyWith(fontSize: 18),
        ),
      ),
      body: ListenableBuilder(
        listenable: ActivityRepository.instance,
        builder: (context, _) {
          final all = ActivityRepository.instance.all;
          final items = _sorted(all);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: _SortDropdown(
                  value: _sort,
                  onChanged: (v) => setState(() => _sort = v),
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? _EmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                        itemCount: items.length,
                        itemBuilder: (context, index) => ActivityTile(
                          key: ValueKey(items[index].id),
                          activity: items[index],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.history_rounded,
                size: 56, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('Belum ada aktivitas.', style: AppTextStyles.emptyState),
          ],
        ),
      ),
    );
  }
}

class _SortDropdown extends StatelessWidget {
  final ActivitySort value;
  final ValueChanged<ActivitySort> onChanged;

  const _SortDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ActivitySort>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.expand_more_rounded, size: 20),
          style: AppTextStyles.todoTitle,
          items: const [
            DropdownMenuItem(
              value: ActivitySort.newest,
              child: Text('Newest first'),
            ),
            DropdownMenuItem(
              value: ActivitySort.oldest,
              child: Text('Oldest first'),
            ),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}