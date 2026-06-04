import 'package:flutter/material.dart';

// Import widget yang udah dipecah tadi
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
  bool isJointMode = true;
  bool isPowerOn = false;
  double speedValue = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20)),
                    child: const Text('POWER OFF |', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- POSITION CARDS ---
              const Row(
                children: [
                  Expanded(child: PositionCard(title: 'J1 Pos', value: '0')),
                  SizedBox(width: 16),
                  Expanded(child: PositionCard(title: 'J2 Pos', value: '0')),
                ],
              ),
              const SizedBox(height: 20),

              // --- MODE TOGGLE ---
              ModeToggleSwitch(
                isJointMode: isJointMode,
                onToggle: () => setState(() => isJointMode = !isJointMode),
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
                        onDrag: (details) { /* TODO: Logic gerak J1 */ },
                        onReset: () { /* TODO: Reset J1 */ },
                      ),
                    ),
                    Container(width: 1, height: 120, color: Colors.grey.shade200), // Garis pemisah
                    Expanded(
                      child: JointControlPad(
                        title: 'Joint 2',
                        onDrag: (details) { /* TODO: Logic gerak J2 */ },
                        onReset: () { /* TODO: Reset J2 */ },
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
                            value: isPowerOn, activeColor: Colors.deepPurple.shade300,
                            onChanged: (val) => setState(() => isPowerOn = val),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 55, alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(16)),
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
                  Text('Speed: ${speedValue.toInt()}%', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                  const Text('Limit: 100%', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red)),
                ],
              ),
              Slider(
                value: speedValue, min: 0, max: 100,
                activeColor: Colors.grey.shade500, inactiveColor: Colors.grey.shade200,
                onChanged: (val) => setState(() => speedValue = val),
              ),
              const SizedBox(height: 24),

              // --- SWIPE TO EMERGENCY STOP ---
              SwipeToStopBtn(
                onStop: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('EMERGENCY STOP TRIGGERED!'), backgroundColor: Colors.red),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}