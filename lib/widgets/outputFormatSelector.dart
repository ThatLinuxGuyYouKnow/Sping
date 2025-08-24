// lib/output_format_selector.dart

import 'package:flutter/material.dart';
import 'package:sping/widgets/formatTabs.dart';

class OutputFormatSelector extends StatefulWidget {
  const OutputFormatSelector({super.key});

  @override
  State<OutputFormatSelector> createState() => _OutputFormatSelectorState();
}

class _OutputFormatSelectorState extends State<OutputFormatSelector> {
  String? _selectedFormat;

  final List<String> imageFormats = [
    'PNG',
    'JPEG',
    'ICO',
    'GIF',
    'JPG',
    'TIFF'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        itemCount: imageFormats.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (BuildContext context, int index) {
          final format = imageFormats[index];

          final bool isSelected = (format == _selectedFormat);

          return FormatTab(
            formatName: format,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                _selectedFormat = format;
              });

              print('$format selected!');
            },
          );
        },
      ),
    );
  }
}
