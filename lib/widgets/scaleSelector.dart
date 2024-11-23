import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sping/model/scaleEnums.dart';

class ScaleSelector extends StatefulWidget {
  final Function(Scale) onScaleSelected;
  final Scale initialScale;

  const ScaleSelector({
    super.key,
    required this.onScaleSelected,
    required this.initialScale,
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
    return Container(
      height: 46,
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
        ),
        segments: [
          ScaleSegment(scale: Scale.same, label: '1x'),
          ScaleSegment(scale: Scale.large, label: '2x'),
          ScaleSegment(scale: Scale.larger, label: '6x'),
          ScaleSegment(scale: Scale.largest, label: '12x'),
        ],
        selected: {selectedScale},
        onSelectionChanged: (Set<Scale> selection) {
          setState(() {
            selectedScale = selection.first;
          });
          widget.onScaleSelected(selection.first);
        },
      ),
    );
  }
}

class ScaleSegment extends ButtonSegment<Scale> {
  ScaleSegment({
    required Scale scale,
    required String label,
  }) : super(
          value: scale,
          label: Text(
            label,
            style: GoogleFonts.ubuntu(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
}
