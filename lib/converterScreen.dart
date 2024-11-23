import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sping/logic/converter.dart';
import 'package:sping/logic/pngTosvgConverter.dart';
import 'package:sping/model/scaleEnums.dart';
import 'package:sping/widgets/scaleSelector.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  bool uploadBoxInFocus = false;
  bool userHasPickedFile = false;
  late String pickedFileName;
  late Uint8List pickedFile;
  late String pngURL;
  Scale selectedScale = Scale.same;

  String getScaleDimension(Scale scale) {
    print(scale);
    switch (scale) {
      case Scale.same:
        print('500');
        return '500'; // 1x
      case Scale.large:
        print('1000');
        return '1000'; // 2x
      case Scale.larger:
        print('3000');
        return '3000'; // 6x
      case Scale.largest:
        print('6000');
        return '6000'; // 12x
      default:
        return '500';
    }
  }

  void handleScaleSelected(Scale scale) {
    setState(() {
      selectedScale = scale;
    });
    print('Selected scale in ConverterScreen: $selectedScale');
  }

  @override
  Widget build(BuildContext context) {
    pickImage() async {
      try {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['svg']);
        Uint8List fileBytes = result!.files.first.bytes!;
        setState(() {
          userHasPickedFile = true;
          pickedFileName = result.files.first.name;
          pickedFile = fileBytes;
        });
        return fileBytes;
      } on Error {
        print(Error);
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 900;
        //  final isMobile = constraints.maxWidth <= 600;

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
                            SizedBox(height: userHasPickedFile ? 30 : 16),
                            GestureDetector(
                              onTap: userHasPickedFile
                                  ? () {}
                                  : () async {
                                      print('Hit Gesture Detector');

                                      await pickImage();
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
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 1.5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.insert_drive_file_outlined,
                                              color: Colors.grey.shade600,
                                              size: 32,
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                pickedFileName,
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  userHasPickedFile = false;
                                                });
                                              },
                                            ),
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
                            userHasPickedFile
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 50),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Scale Factor',
                                          style: GoogleFonts.ubuntu(),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: containerWidth * 0.8,
                                            child: ScaleSelector(
                                              isSmallScreen:
                                                  !isDesktop && !isTablet,
                                              initialScale:
                                                  selectedScale, // Pass the initial scale
                                              onScaleSelected:
                                                  handleScaleSelected,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: 80,
                                  ),
                            Center(
                                child: GestureDetector(
                              onTap: () async {
                                if (userHasPickedFile) {
                                  final svgContent = utf8.decode(pickedFile);
                                  final converter = SvgToPngConverter(
                                    svgContent: svgContent,
                                    scaleWidth:
                                        getScaleDimension(selectedScale),
                                    scaleHeight:
                                        getScaleDimension(selectedScale),
                                  );
                                  String url =
                                      await converter.convertSvgToPng();
                                  setState(() {
                                    pngURL = url;
                                  });

                                  converter.downloadPng(pngURL);
                                }
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
                                      'Convert to PNG', // Updated text to match functionality
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
                            )),
                            const SizedBox(height: 200),
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

class _FooterLink extends StatelessWidget {
  final String text;

  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            // Add navigation logic here
          },
          child: Text(
            text,
            style: GoogleFonts.ubuntu(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ),
      ),
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
            ' SVG To PNG Converter',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: isDesktop ? 32 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isDesktop)
          ElevatedButton(
            onPressed: () {
              launchUrlToSite();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.sync_alt,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Convert PNG to SVG here',
                    style:
                        GoogleFonts.ubuntu(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
