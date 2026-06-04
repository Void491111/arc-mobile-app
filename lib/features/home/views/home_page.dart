import 'package:flutter/material.dart';

import '../../activity/views/activity_page.dart';
import '../controllers/home_controller.dart';
import '../widgets/activity_section.dart';
import '../widgets/app_bottom_nav.dart';
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
  late final HomeController _controller;
  int _activeNavIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
    _controller.init();
  }

  @override
  void dispose() {
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(
                          greeting: _greetingFor(_controller.now.hour),
                          operatorName: _controller.operatorName,
                          onSettingsTap: () {},
                        ),
                        const SizedBox(height: 18),
                        StatusCard(
                          systemStatus: _controller.systemStatus,
                          machineLabel: _controller.machineStateLabel(),
                          now: _controller.now,
                          uptime: _controller.sessionUptime,
                        ),
                        const SizedBox(height: 28),
                        TodoSection(
                          todos: _controller.todos,
                          onAdd: _showAddTodoDialog,
                          onToggle: _controller.toggleTodo,
                          onRemove: _controller.removeTodo,
                        ),
                        const SizedBox(height: 28),
                        ActivitySection(onViewAll: _openActivityPage),
                      ],
                    ),
                  ),
                ),
                AppBottomNav(
                  activeIndex: _activeNavIndex,
                  onTap: (i) => setState(() => _activeNavIndex = i),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}