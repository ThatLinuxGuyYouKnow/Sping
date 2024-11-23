import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sping/logic/converter.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

bool uploadBoxInFocus = false;
bool userHasPickedFile = false;
late String pickedFileName;
late PlatformFile pickedFile;
late String pngURL;

class _ConverterScreenState extends State<ConverterScreen> {
  @override
  Widget build(BuildContext context) {
    _pickImage() async {
      try {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['svg']);
        Uint8List fileBytes = result!.files.first.bytes!;
        setState(() {
          userHasPickedFile = true;
          pickedFileName = result.files.first.name;
        });
        return fileBytes;
      } catch (Error) {
        print(Error);
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 900;
        final isMobile = constraints.maxWidth <= 600;

        final containerWidth = isDesktop
            ? constraints.maxWidth * 0.4
            : isTablet
                ? constraints.maxWidth * 0.6
                : constraints.maxWidth * 0.85;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.black,
            title: ResponsiveAppBar(isDesktop: isDesktop),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.05,
                vertical: 20,
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      width: containerWidth,
                      constraints: const BoxConstraints(
                        minHeight: 350,
                        maxHeight: 450,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upload SVG File',
                              style: GoogleFonts.ubuntu(
                                fontSize: isDesktop ? 20 : 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: userHasPickedFile
                                  ? () {}
                                  : () async {
                                      print('Hit Gesture Detector');

                                      final selectedFile = await _pickImage();

                                      if (selectedFile != null) {
                                        // Read file content as string (SVG content)
                                        final svgContent =
                                            utf8.decode(selectedFile);

                                        // Pass content to the converter
                                        final converter = SvgToPngConverter(
                                          svgContent: svgContent,
                                          scaleWidth:
                                              '500', // Optional, can adjust dynamically
                                          scaleHeight: '500',
                                        );

                                        setState(() async {
                                          pngURL = await converter
                                              .convertSvgToPng(); // Ensure it's awaited
                                        });
                                      } else {
                                        print(
                                            'No file was selected or an error occurred.');
                                      }
                                    },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onExit: (event) {
                                  setState(() {
                                    uploadBoxInFocus = false;
                                  });
                                },
                                onEnter: (event) => setState(() {
                                  uploadBoxInFocus = true;
                                }),
                                child: userHasPickedFile
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              pickedFileName,
                                              style: GoogleFonts.ubuntu(),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: isDesktop ? 200 : 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: uploadBoxInFocus
                                                ? Colors.black.withOpacity(0.4)
                                                : Colors.grey.shade400,
                                            style: BorderStyle.solid,
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.upload_outlined,
                                                size: 32,
                                                color: uploadBoxInFocus
                                                    ? Colors.black
                                                    : Colors.grey.shade600,
                                              ),
                                              const SizedBox(height: 12),
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  style: GoogleFonts.ubuntu(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  children: [
                                                    const TextSpan(
                                                        text:
                                                            'Click to upload '),
                                                    TextSpan(
                                                      text:
                                                          'or drag and drop\n',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'PNG file up to 10MB',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  final converter = SvgToPngConverter(
                                      svgContent:
                                          ''); // dummy svg data, doesnt matter since itll never be accessed
                                  converter.downloadPng(pngURL);
                                },
                                child: Container(
                                  width: isDesktop
                                      ? containerWidth * 0.8
                                      : containerWidth * 0.9,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: userHasPickedFile
                                        ? Colors.black
                                        : Colors.grey.shade400,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Convert to SVG',
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ResponsiveAppBar extends StatelessWidget {
  final bool isDesktop;

  const ResponsiveAppBar({
    super.key,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'PNG To SVG Converter',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: isDesktop ? 32 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isDesktop)
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Text(
              'Convert SVG to PNG here',
              style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black),
            ),
          ),
      ],
    );
  }
}
