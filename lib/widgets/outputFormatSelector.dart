import 'package:flutter/material.dart';
import 'package:sping/widgets/formatTabs.dart';

class OutputFormatSelector extends StatelessWidget {
  const OutputFormatSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageFormats = [
      'PNG',
      'JPEG',
      'ICO',
      'GIF',
      'JPG',
      'TIFF'
    ];

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
          return FormatTab(formatName: imageFormats[index]);
        },
      ),
    );
  }
}
