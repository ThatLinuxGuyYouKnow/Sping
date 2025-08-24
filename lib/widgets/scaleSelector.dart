import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sping/model/scaleEnums.dart';
import 'package:sping/widgets/scaleTextfields.dart';

class ScaleSelector extends StatefulWidget {
  final Function(Scale) onScaleSelected;
  final Scale initialScale;
  final bool isSmallScreen;

  const ScaleSelector({
    super.key,
    required this.onScaleSelected,
    required this.initialScale,
    required this.isSmallScreen,
  });

  @override
  State<ScaleSelector> createState() => _ScaleSelectorState();
}

class _ScaleSelectorState extends State<ScaleSelector> {
  late Scale selectedScale;

  @override
  void initState() {
    super.initState();
    selectedScale = widget.initialScale;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.isSmallScreen ? 40 : 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SegmentedButton<Scale>(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                  return Colors.white;
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white;
                  }
                  return Colors.black87;
                },
              ),
              side: MaterialStateProperty.all(
                BorderSide(color: Colors.grey.shade200),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Add padding adjustment for small screens
              padding: MaterialStateProperty.all(widget.isSmallScreen
                  ? const EdgeInsets.symmetric(horizontal: 4)
                  : const EdgeInsets.symmetric(horizontal: 8)),
              // Adjust the minimum size
              minimumSize: MaterialStateProperty.all(widget.isSmallScreen
                  ? const Size(40, 32)
                  : const Size(48, 40)),
              maximumSize: MaterialStateProperty.all(widget.isSmallScreen
                  ? const Size(60, 32)
                  : const Size(80, 40)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            segments: [
              ScaleSegment(
                scale: Scale.same,
                label: '1x',
                isSmallScreen: widget.isSmallScreen,
              ),
              ScaleSegment(
                scale: Scale.large,
                label: '2x',
                isSmallScreen: widget.isSmallScreen,
              ),
              ScaleSegment(
                scale: Scale.larger,
                label: '6x',
                isSmallScreen: widget.isSmallScreen,
              ),
              ScaleSegment(
                scale: Scale.largest,
                label: '12x',
                isSmallScreen: widget.isSmallScreen,
              ),
            ],
            selected: {selectedScale},
            onSelectionChanged: (Set<Scale> selection) {
              setState(() {
                selectedScale = selection.first;
              });
              widget.onScaleSelected(selection.first);
            },
          ),
        ),
        Row(
          children: [ScaleTextFields(isDesktop: true, hintText: 'height')],
        )
      ],
    );
  }
}

class ScaleSegment extends ButtonSegment<Scale> {
  ScaleSegment({
    required bool isSmallScreen,
    required Scale scale,
    required String label,
  }) : super(
          value: scale,
          label: Container(
            constraints: BoxConstraints(
              maxWidth: isSmallScreen ? 40 : 60,
            ),
            child: Text(
              label,
              style: GoogleFonts.ubuntu(
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: isSmallScreen ? FontWeight.w400 : FontWeight.w600,
                height: 1, // Reduce line height
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
          ),
        );
}
