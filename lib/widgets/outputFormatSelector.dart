import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sping/providers/progressProviders.dart';
import 'package:sping/widgets/formatTabs.dart';
import 'package:sping/widgets/resizerPromptDialog.dart';

class OutputFormatSelector extends StatefulWidget {
  const OutputFormatSelector({super.key, this.originalImageFormat = ''});
  final String originalImageFormat;

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
    final progressProvider = Provider.of<ProgressProvider>(context);
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          const Row(
            children: [Text('Convert this image to ')],
          ),
          const SizedBox(height: 20),
          GridView.builder(
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
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              progressProvider.setHasSelectedOutputFormat(true);

              final bool? shouldResize = await showResizerDialog(context);

              if (shouldResize ?? true) {
                progressProvider.setHasSelectedOutputFormat(true);
              }
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Next',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white, fontSize: 16)),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
