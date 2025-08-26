import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sping/model/scaleEnums.dart';
import 'package:sping/widgets/scaleTextfields.dart';

class ScaleSelector extends StatefulWidget {
  final Function(Scale) onScaleSelected;
  final Scale initialScale;
  final bool isSmallScreen;
  final Map<String, String> imageDimensions;

  const ScaleSelector({
    super.key,
    required this.onScaleSelected,
    required this.initialScale,
    required this.isSmallScreen,
    required this.imageDimensions,
  });

  @override
  State<ScaleSelector> createState() => _ScaleSelectorState();
}

class _ScaleSelectorState extends State<ScaleSelector> {
  late Scale selectedScale;
  late TextEditingController _widthController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    selectedScale = widget.initialScale;

    // Set the initial text of the controllers here, using the passed-in data.
    _widthController =
        TextEditingController(text: widget.imageDimensions['width'] ?? '');
    _heightController =
        TextEditingController(text: widget.imageDimensions['height'] ?? '');
  }

  // Use didUpdateWidget to react when the parent passes in NEW data.
  @override
  void didUpdateWidget(ScaleSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    // This is crucial: only update if the dimensions have actually changed.
    if (widget.imageDimensions != oldWidget.imageDimensions) {
      _updateControllers(
        widget.imageDimensions['width'] ?? '',
        widget.imageDimensions['height'] ?? '',
      );
    }
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _updateControllers(String width, String height) {
    if (_widthController.text != width) {
      _widthController.text = width;
    }
    if (_heightController.text != height) {
      _heightController.text = height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Resizer',
            style:
                GoogleFonts.ubuntu(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Width'),
                  const SizedBox(height: 4),
                  ScaleTextFields(
                    hintText: 'Width',
                    controller: _widthController,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Height'),
                  const SizedBox(height: 4),
                  ScaleTextFields(
                    hintText: 'Height',
                    controller: _heightController,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
