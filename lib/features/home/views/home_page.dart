// lib/features/home/views/home_page.dart
import 'package:flutter/material.dart';

import '../../activity/views/activity_page.dart';
import '../controllers/home_controller.dart';
import '../widgets/activity_section.dart';
import '../widgets/home_header.dart';
import '../widgets/status_card.dart';
import '../widgets/todo_dialog.dart';
import '../widgets/todo_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _todoScrollController = ScrollController();
  final ScrollController _activityScrollController = ScrollController();

  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
    _controller.init();
  }

  @override
  void dispose() {
    _todoScrollController.dispose();
    _activityScrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  String _greetingFor(int hour) {
    if (hour < 11) return 'Good Morning,';
    if (hour < 15) return 'Good Afternoon,';
    if (hour < 19) return 'Good Evening,';
    return 'Good Night,';
  }

  Future<void> _showAddTodoDialog() async {
    final result = await AddTodoDialog.show(context);
    if (result != null && result.isNotEmpty) {
      await _controller.addTodo(result);
    }
  }

  void _openActivityPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ActivityPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. HEADER ---
                  HomeHeader(
                    greeting: _greetingFor(DateTime.now().hour),
                    operatorName: 'Alif Hidayat', // Nama operator dipasang di sini
                    onSettingsTap: () {
                      // Kosongin dulu boss buat nanti
                    },
                  ), 

                  const SizedBox(height: 16),

                  // --- 2. STATUS CARD ---
                  StatusCard(
                    systemStatus: SystemStatus.offline, 
                    machineLabel: 'Arc Machine',
                    now: DateTime.now(),
                    uptime: const Duration(hours: 0, minutes: 0, seconds: 0),
                  ), 

                  const SizedBox(height: 16),

                  // --- 3. SECTION: MY TODO LIST ---
                  Expanded(
                    flex: 3, 
                    child: TodoSection(
                      todos: _controller.todos, // Mengambil list dari controller
                      onAdd: _showAddTodoDialog,
                      onToggle: _controller.toggleTodo, 
                      onRemove: _controller.removeTodo,
                      scrollController: _todoScrollController,
                      // TODO: Hapus komen di bawah ini KALAU file todo_section.dart udah boss update!
                      // scrollController: _todoScrollController, 
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- 4. SECTION: RECENT ACTIVITY ---
                  Expanded(
                    flex: 2, 
                    child: ActivitySection(
                      onViewAll: _openActivityPage,
                      scrollController: _activityScrollController,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}