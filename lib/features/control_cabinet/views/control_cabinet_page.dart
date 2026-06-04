// lib/features/control_cabinet/views/control_cabinet_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/cabinet_controller.dart';
import '../widgets/io_card_wrapper.dart';
import '../widgets/edit_label_dialog.dart';
import '../widgets/input_indicator.dart';
import '../widgets/output_switch.dart';
import 'package:toastification/toastification.dart';

class ControlCabinetPage
    extends
        StatefulWidget {
  const ControlCabinetPage({
    super.key,
  });

  @override
  State<
    ControlCabinetPage
  >
  createState() => _ControlCabinetPageState();
}

class _ControlCabinetPageState
    extends
        State<
          ControlCabinetPage
        > {
  final CabinetController _controller = CabinetController();

  // 1. Inisialisasi ScrollController yang benar boss
  final ScrollController _outputScrollController = ScrollController();

  @override
  void dispose() {
    // 2. Wajib dispose biar memori aman
    _outputScrollController.dispose();
    super.dispose();
  }

  // 3. Fungsi dialog ditaruh di dalam state yang sama dengan rapi
  Future<
    void
  >
  _showEditLabelDialog(
    BuildContext context,
    bool isInput,
    int index,
    String currentLabel,
  ) async {
    final newLabel =
        await showDialog<
          String
        >(
          context: context,
          builder:
              (
                context,
              ) => EditLabelDialog(
                currentLabel: currentLabel,
              ),
        );

    if (newLabel !=
            null &&
        newLabel.trim().isNotEmpty) {
      if (isInput) {
        _controller.updateInputLabel(
          index,
          newLabel.trim(),
        );
      } else {
        _controller.updateOutputLabel(
          index,
          newLabel.trim(),
        );
      }
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FA,
      ),
      appBar: AppBar(
        backgroundColor: const Color(
          0xFFF8F9FA,
        ),
        elevation: 0,
        title: Text(
          'Control Cabinet',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(
              0xFFD32F2F,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder:
            (
              context,
              child,
            ) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    // SECTION: DIGITAL INPUT (Pas & Non-scroll)
                    Expanded(
                      child: IOCardWrapper(
                        title: 'Digital Input',
                        trailing: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(
                                  0xFFD32F2F,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Off',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1.3,
                          ),
                          itemCount: _controller.digitalInputs.length,
                          itemBuilder:
                              (
                                context,
                                index,
                              ) {
                                final item = _controller.digitalInputs[index];
                                return InputIndicator(
                                  label: item.label,
                                  isOn: item.isOn,
                                  onEdit: () => _showEditLabelDialog(
                                    context,
                                    true,
                                    index,
                                    item.label,
                                  ),
                                );
                              },
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // SECTION: DIGITAL OUTPUT (Scrollable dengan Scrollbar internal)
                    Expanded(
                      child: IOCardWrapper(
                        title: 'Digital Output',
                        child: Scrollbar(
                          controller: _outputScrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          thickness: 4.0,
                          radius: const Radius.circular(
                            8,
                          ),
                          child: GridView.builder(
                            controller: _outputScrollController,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 8,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: _controller.digitalOutputs.length,
                            itemBuilder:
                                (
                                  context,
                                  index,
                                ) {
                                  final item = _controller.digitalOutputs[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8.0,
                                    ),
                                    child: OutputSwitch(
                                      label: item.label,
                                      isOn: item.isOn,
                                      onChanged:
                                          (
                                            val,
                                          ) => _controller.toggleOutput(
                                            index,
                                            val,
                                          ),
                                      onEdit: () => _showEditLabelDialog(
                                        context,
                                        false,
                                        index,
                                        item.label,
                                      ),
                                    ),
                                  );
                                },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            },
      ),
    );
  }
}
