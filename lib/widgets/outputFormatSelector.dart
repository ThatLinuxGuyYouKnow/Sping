import 'package:flutter/material.dart';
import 'package:sping/widgets/formatTabs.dart';

class OutputFormatSelector extends StatelessWidget {
  const OutputFormatSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image format names to display.
    final List<String> imageFormats = [
      'PNG',
      'JPEG',
      'ICO',
      'GIF',
      'JPG',
      'TIFF'
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: imageFormats.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Return a FormatTab for each format name in the list.
          return FormatTab(formatName: imageFormats[index]);
        },
      ),
    );
  }
}
