// lib/features/control_panel/views/control_panel_page.dart
import 'package:flutter/material.dart';

import '../controllers/control_panel_controller.dart';
import '../widgets/position_card.dart';
import '../widgets/mode_toggle_switch.dart';
import '../widgets/joint_control.dart';
import '../widgets/swipe_to_stop_btn.dart';

class ControlPanelPage extends StatefulWidget {
  const ControlPanelPage({super.key});

  @override
  State<ControlPanelPage> createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage> {
  // Inisialisasi controller panel kontrol
  late final ControlPanelController _panelController;

  @override
  void initState() {
    super.initState();
    _panelController = ControlPanelController();
  }

  @override
  void dispose() {
    _panelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _panelController,
          builder: (context, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Control Panel', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _panelController.isPowerOn ? 'POWER ON |' : 'POWER OFF |',
                          style: TextStyle(
                            color: _panelController.isPowerOn ? Colors.green : Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- POSITION CARDS ---
                  Row(
                    children: [
                      Expanded(child: PositionCard(title: 'J1 Pos', value: _panelController.j1Pos.toInt().toString())),
                      const SizedBox(width: 16),
                      Expanded(child: PositionCard(title: 'J2 Pos', value: _panelController.j2Pos.toInt().toString())),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- MODE TOGGLE ---
                  ModeToggleSwitch(
                    isJointMode: _panelController.isJointMode,
                    onToggle: _panelController.toggleMode,
                  ),
                  const SizedBox(height: 20),

                  // --- MAIN CONTROL CARD (Joystick) ---
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red.shade100),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: JointControlPad(
                            title: 'Joint 1',
                            onDrag: (details) => _panelController.updateJ1(details.x), // Otomatis nambah koordinat pas di-drag
                            onReset: _panelController.resetJ1,
                          ),
                        ),
                        Container(width: 1, height: 120, color: Colors.grey.shade200),
                        Expanded(
                          child: JointControlPad(
                            title: 'Joint 2',
                            onDrag: (details) => _panelController.updateJ2(details.x),
                            onReset: _panelController.resetJ2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- POWER & START BUTTON ---
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55, padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Power', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Switch(
                                value: _panelController.isPowerOn,
                                activeColor: Colors.deepPurple.shade300,
                                onChanged: _panelController.togglePower,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 55, alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _panelController.isPowerOn ? Colors.green : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text('START', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.5)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- SPEED SLIDER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Speed: ${_panelController.speedValue.toInt()}%', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                      const Text('Limit: 100%', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red)),
                    ],
                  ),
                  Slider(
                    value: _panelController.speedValue, min: 0, max: 100,
                    activeColor: Colors.grey.shade500, inactiveColor: Colors.grey.shade200,
                    onChanged: _panelController.updateSpeed,
                  ),
                  const SizedBox(height: 24),

                  // --- SWIPE TO EMERGENCY STOP ---
                  SwipeToStopBtn(
                    onStop: () async {
                      _panelController.emergencyStop(); // Triggers e-stop logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('EMERGENCY STOP TRIGGERED! 🚨'), backgroundColor: Colors.red),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}