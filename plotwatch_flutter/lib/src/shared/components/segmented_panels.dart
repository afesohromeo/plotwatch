import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// One panel of [SegmentedPanels].
class Panel {
  const Panel({required this.label, required this.child});

  final String label;
  final Widget child;
}

/// A page's secondary content on a phone, one panel at a time behind a
/// segmented switch, instead of a long column of cards (doc/05 §9.4). The
/// hidden panels stay alive, so switching back doesn't reload them.
class SegmentedPanels extends StatefulWidget {
  const SegmentedPanels({super.key, required this.panels});

  final List<Panel> panels;

  static Key segmentKey(int index) => Key('segment.$index');

  @override
  State<SegmentedPanels> createState() => _SegmentedPanelsState();
}

class _SegmentedPanelsState extends State<SegmentedPanels> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final panels = widget.panels;
    if (panels.isEmpty) return const SizedBox.shrink();
    // A switch with one segment chooses nothing.
    if (panels.length == 1) return panels.single.child;
    final selected = _selected.clamp(0, panels.length - 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The switch: the ground as a track, the chosen segment in white.
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: customColors.lineSoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              for (var i = 0; i < panels.length; i++)
                Expanded(
                  child: Semantics(
                    selected: i == selected,
                    button: true,
                    child: InkWell(
                      key: SegmentedPanels.segmentKey(i),
                      borderRadius: BorderRadius.circular(9),
                      onTap: () => setState(() => _selected = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: i == selected
                              ? customColors.surfaceWhite
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                          boxShadow: i == selected
                              ? const [
                                  BoxShadow(
                                    color: Color(0x1415201E),
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          panels[i].label,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: i == selected
                                ? customColors.ink
                                : customColors.muted,
                            fontWeight: i == selected
                                ? FontWeight.w800
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Gap.vertical(height: 12),
        for (var i = 0; i < panels.length; i++)
          Visibility(
            visible: i == selected,
            maintainState: true,
            child: panels[i].child,
          ),
      ],
    );
  }
}
