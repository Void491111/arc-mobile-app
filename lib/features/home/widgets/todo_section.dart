import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/todo_model.dart';
import 'section_header.dart';

class TodoSection extends StatelessWidget {
  final List<TodoModel> todos;
  final VoidCallback onAdd;
  final Future<void> Function(String id) onToggle;
  final Future<void> Function(String id) onRemove;
  
  // 1. Tambahkan parameter scrollController boss!
  final ScrollController scrollController; 

  const TodoSection({
    super.key,
    required this.todos,
    required this.onAdd,
    required this.onToggle,
    required this.onRemove,
    required this.scrollController, // Wajib diisi saat dipanggil di HomePage
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'My Todo List',
          trailing: _AddButton(onTap: onAdd),
        ),
        const SizedBox(height: 14),
        
        // 2. Gunakan Expanded & ListView biar nggak overflow
        Expanded(
          child: todos.isEmpty
              ? const _EmptyTodos()
              : Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true, // Biar bar scroll-nya kelihatan
                  thickness: 4.0,
                  radius: const Radius.circular(8),
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero, // Hilangkan padding bawaan biar rapi
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final t = todos[index];
                      return _TodoTile(
                        key: ValueKey(t.id),
                        todo: t,
                        onToggle: () => onToggle(t.id),
                        onRemove: () => onRemove(t.id),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.accentBlue,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.add_rounded, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _EmptyTodos extends StatelessWidget {
  const _EmptyTodos();

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
        'Tidak ada tugas. Aman Boss! ☕',
        textAlign: TextAlign.center,
        style: AppTextStyles.emptyState,
      ),
    );
  }
}

class _TodoTile extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onToggle;
  final VoidCallback onRemove;

  const _TodoTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Checkbox(
            value: todo.completed,
            onChanged: (_) => onToggle(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            activeColor: AppColors.accentBlue,
          ),
          Expanded(
            child: Text(
              todo.title,
              style: AppTextStyles.todoTitle.copyWith(
                decoration: todo.completed ? TextDecoration.lineThrough : null,
                color: todo.completed
                    ? AppColors.textTertiary
                    : AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.textTertiary,
              size: 20,
            ),
            splashRadius: 18,
          ),
        ],
      ),
    );
  }
}