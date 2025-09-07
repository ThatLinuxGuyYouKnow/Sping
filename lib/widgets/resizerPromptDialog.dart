import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sping/providers/progressProviders.dart';
import 'package:sping/utils/converter.dart';
import 'package:sping/utils/downloadFile.dart';
import 'package:path/path.dart' as path;

Future<bool?> showResizerDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resize Image?',
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Do you want to specify a new width and height for this image?',
                style: GoogleFonts.ubuntu(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () async {
                      final progressProvider =
                          Provider.of<ProgressProvider>(context, listen: false);
                      final isSVG = progressProvider.isSvgFile;
                      final bytes = progressProvider.imageBytes;

                      final baseName = path.basenameWithoutExtension(
                          progressProvider.originalFileName);
                      final newExtension =
                          progressProvider.outputFormat.toLowerCase();
                      final newFileName = '$baseName.$newExtension';

                      Navigator.of(context).pop(false);
                      if (isSVG) {
                        await downloadWithFeedback(
                            context, bytes!, newFileName);
                      } else {
                        convertAndDownloadSvg(
                            svgBytes: bytes!,
                            outputFormat: progressProvider.outputFormat,
                            imageName: newFileName);
                      }
                    },
                    child: Text(
                      'NO, SKIP',
                      style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 4),
                  ElevatedButton(
                    onPressed: () {
                      final progressProvider =
                          Provider.of<ProgressProvider>(context, listen: false);
                      progressProvider.setUserwantsToResizeStatus(true);

                      progressProvider.clearImageBytes;
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                    ),
                    child: Text(
                      'YES, RESIZE',
                      style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
