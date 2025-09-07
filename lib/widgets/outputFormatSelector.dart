import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sping/providers/progressProviders.dart';
import 'package:sping/utils/converter.dart';
import 'package:sping/utils/downloadFile.dart';

import 'package:sping/utils/generalConverter.dart';
import 'package:sping/widgets/formatTabs.dart';
import 'package:sping/widgets/resizerPromptDialog.dart';
import 'package:path/path.dart' as path;

class OutputFormatSelector extends StatefulWidget {
  const OutputFormatSelector(
      {super.key, this.originalImageFormat = '', this.imageDimensions});
  final String originalImageFormat;
  final imageDimensions;

  @override
  State<OutputFormatSelector> createState() => _OutputFormatSelectorState();
}

class _OutputFormatSelectorState extends State<OutputFormatSelector> {
  String? _selectedFormat;

  final List<String> imageFormats = ['PNG', 'TGA', 'ICO', 'GIF', 'JPG', 'TIFF'];

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
                  progressProvider.setOutputFormat(
                      outputFormat: _selectedFormat!);
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
              if (_selectedFormat == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Please select an output format first!")),
                );
                return;
              }

              final bool? shouldResize = await showResizerDialog(context);

              if (shouldResize == null) {
                return;
              }

              if (shouldResize) {
                progressProvider.setHasSelectedOutputFormat(true);
              } else {
                final bytes = progressProvider.imageBytes;
                if (bytes == null) return;

                final baseName = path.basenameWithoutExtension(
                    progressProvider.originalFileName);
                final newExtension =
                    progressProvider.outputFormat.toLowerCase();
                final newFileName = '$baseName.$newExtension';
                final isSVG = progressProvider.isSvgFile;

                if (isSVG) {
                  await convertAndDownloadSvg(
                    imageName: newFileName,
                    svgBytes: bytes,
                    outputFormat: progressProvider.outputFormat,
                    outputHeight:
                        int.parse(progressProvider.imageDimensions['height']!),
                    outputWidth:
                        int.parse(progressProvider.imageDimensions['width']!),
                  );
                } else {
                  final convertedBytes = await convertAndResizeImage(
                    bytes,
                    progressProvider.originalImageFormat,
                    progressProvider.outputFormat,
                    targetHeight:
                        int.parse(progressProvider.imageDimensions['height']!),
                    targetWidth:
                        int.parse(progressProvider.imageDimensions['width']!),
                  );

                  if (convertedBytes != null) {
                    downloadFile(convertedBytes, fileName: newFileName);
                  }
                }
              }
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Convert',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
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
