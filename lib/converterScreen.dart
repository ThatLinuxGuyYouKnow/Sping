import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sping/providers/progressProviders.dart';
import 'package:sping/utils/converter.dart';

import 'package:sping/utils/filePicker.dart';
import 'package:path/path.dart' as path;
import 'package:sping/model/scaleEnums.dart';
import 'package:sping/utils/getImageDimensions.dart';
import 'package:sping/widgets/appBar.dart';
import 'package:sping/widgets/errorSnackbar.dart';
import 'package:sping/widgets/fileTab.dart';
import 'package:sping/widgets/footer.dart';
import 'package:sping/widgets/outputFormatSelector.dart';
import 'package:sping/widgets/scaleSelector.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  bool uploadBoxInFocus = false;

  String? pickedFileName;
  late Uint8List pickedFile;
  late String pngURL;
  Scale selectedScale = Scale.same;
  String originalImageFormat = '';

  void handleScaleSelected(Scale scale) {
    setState(() {
      selectedScale = scale;
    });
    print('Selected scale in ConverterScreen: $selectedScale');
  }

  bool fallbackValidator(String filename, List<String> allowedExtensions) {
    String extension = path.extension(filename);

    if (extension.isEmpty) {
      return false;
    }

    String cleanExtension = extension.substring(1).toLowerCase();

    return allowedExtensions.contains(cleanExtension);
  }

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    final bool userHasPickedFile = progressProvider.userHasPickedFile;
    final bool selectedOutputFormat =
        progressProvider.userHasSelectedOutputFormat;
    final bool userWantsToResize = progressProvider.userWantsToResizeImage;
    final bool userHasSelectedOutputFormat =
        progressProvider.userHasSelectedOutputFormat;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 900;
        //  final isMobile = constraints.maxWidth <= 600;

        final double containerHeight;
        if (!userHasPickedFile) {
          // State 1: Initial upload prompt
          containerHeight = isDesktop ? 380 : 340;
        } else if (userHasPickedFile && !userHasSelectedOutputFormat) {
          // State 2: User picked a file, now showing format selection
          containerHeight = isDesktop ? 540 : 420; // Largest height
        } else if (userWantsToResize) {
          // State 3: User selected format, now showing resize options
          containerHeight =
              isDesktop ? 410 : 320; // Medium height (smaller than state 2)
        } else {
          containerHeight = isDesktop ? 380 : 340;
        }

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
                    const SizedBox(height: 100),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                              'Upload Image File',
                              style: GoogleFonts.ubuntu(
                                fontSize: isDesktop ? 20 : 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: userHasPickedFile ? 30 : 16),
                            GestureDetector(
                              onTap: () async {
                                print('Hit Gesture Detector');
                                final resultData = await pickFiles();

                                if (resultData != null) {
                                  String fileName = resultData['name'];
                                  Uint8List fileBytes = resultData['bytes'];
                                  String originalImageFormat =
                                      resultData['extension'];
                                  bool isSVG = resultData['isSVG'] == true;

                                  num finalWidth = 0;
                                  num finalHeight = 0;

                                  try {
                                    if (isSVG) {
                                      progressProvider.setsvgFile(true);

                                      final svgDimensions =
                                          await getSvgDimensions(
                                              imageBytes: fileBytes);
                                      finalWidth = svgDimensions['width'] ?? 0;
                                      finalHeight =
                                          svgDimensions['height'] ?? 0;
                                    } else {
                                      final imageDimensions =
                                          await getImageSizeFromBytes(
                                              fileBytes);
                                      finalWidth = imageDimensions!.width;
                                      finalHeight = imageDimensions.height;
                                    }
                                  } catch (e) {
                                    buildErrorSnackbar(context,
                                        "Could not determine image dimensions. Error: $e");
                                    return;
                                  }

                                  progressProvider.setOriginalFileName(
                                      filename: fileName);
                                  progressProvider.setImageBytes(fileBytes);
                                  progressProvider.setImageDimensions(
                                    height: finalHeight.toString(),
                                    width: finalWidth.toString(),
                                  );

                                  if (fallbackValidator(fileName, [
                                    'png',
                                    'svg',
                                    'tiff',
                                    'ico',
                                    'jpeg',
                                    'jpg'
                                  ])) {
                                    progressProvider.setPickedFileStatus(true);
                                    progressProvider.setOriginalImageFormat(
                                        originalImageFormat);

                                    setState(() {
                                      pickedFile = fileBytes;
                                      pickedFileName = fileName;
                                    });
                                  } else {
                                    buildErrorSnackbar(context,
                                        "Looks like this file isn't supported!");
                                  }
                                } else {
                                  buildErrorSnackbar(
                                      context, "No file selected!");
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
                                    ? FileTab(selectedFileName: pickedFileName!)
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            userHasPickedFile
                                ? selectedOutputFormat
                                    ? ScaleSelector(
                                        isSmallScreen: !isDesktop && !isTablet,
                                      )
                                    : OutputFormatSelector()
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Footer(
            constraints: constraints,
            isSmallScreen: !isDesktop && !isTablet,
          ),
        );
      },
    );
  }
}
