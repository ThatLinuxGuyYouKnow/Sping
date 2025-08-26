import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sping/model/scaleEnums.dart';
import 'package:sping/providers/progressProviders.dart';
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
  late TextEditingController _widthController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    selectedScale = widget.initialScale;
    _widthController = TextEditingController();
    _heightController = TextEditingController();
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
    final progressProvider = Provider.of<ProgressProvider>(context);
    final imageDimensions = progressProvider.imageDimensions;
    final String originalHeight = imageDimensions['height'] ?? '';
    final String originalWidth = imageDimensions['width'] ?? '';

    _updateControllers(originalWidth, originalHeight);

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
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Width'),
                    ],
                  ),
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
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Height'),
                    ],
                  ),
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
