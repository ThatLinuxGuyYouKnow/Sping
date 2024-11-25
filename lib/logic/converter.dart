import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

class SvgToPngConverter {
  final String svgContent;
  final int? scaleHeight;
  final int? scaleWidth;

  SvgToPngConverter({
    required this.svgContent,
    this.scaleHeight,
    this.scaleWidth,
  });

  Future<String> convertSvgToPng() async {
    try {
      print('Converting with dimensions: ${scaleWidth}x${scaleHeight}');

      // Parse dimensions with fallback to 500
      final width = int.tryParse(scaleWidth.toString()!);
      final height = int.tryParse(scaleHeight.toString());

      print('Parsed dimensions: ${width}x${height}');

      // Create canvas with specified dimensions
      final canvasElement = html.CanvasElement(
        width: width,
        height: height,
      );

      final context = canvasElement.context2D;

      // Clear the canvas first
      context.clearRect(0, 0, width!, height!);

      // Load and scale the SVG image
      final image = await _svgToImage();

      // Calculate scaling factors to maintain aspect ratio
      final aspectRatio = image.naturalWidth / image.naturalHeight;
      double scaledWidth = width.toDouble();
      double scaledHeight = height.toDouble();

      if (width / height > aspectRatio) {
        scaledWidth = height * aspectRatio;
      } else {
        scaledHeight = width / aspectRatio;
      }

      // Center the image on the canvas
      final x = (width - scaledWidth) / 2;
      final y = (height - scaledHeight) / 2;

      // Draw the image with proper scaling
      context.drawImageScaled(
        image,
        x,
        y,
        scaledWidth,
        scaledHeight,
      );

      // Convert to PNG with maximum quality
      final pngDataUrl = canvasElement.toDataUrl('image/png', 1.0);

      print('Conversion completed. Data URL length: ${pngDataUrl.length}');
      return pngDataUrl;
    } catch (e) {
      print('Conversion error: $e');
      rethrow;
    }
  }

  Future<html.ImageElement> _svgToImage({required int scale}) async {
    final completer = Completer<html.ImageElement>();
    final img = html.ImageElement();

    // Set up load and error handlers
    img.onLoad.listen((_) {
      print(
          'SVG loaded successfully. Natural dimensions: ${img.naturalWidth}x${img.naturalHeight}');
      completer.complete(img);
    });

    img.onError.listen((error) {
      print('SVG load error: $error');
      completer.completeError('Image load error');
    });

    try {
      // Ensure SVG content is properly formatted
      final cleanSvgContent = svgContent.trim();

      // Convert SVG to data URL
      final svgDataUrl =
          'data:image/svg+xml;base64,${base64Encode(utf8.encode(cleanSvgContent))}';

      // Set the source
      img.src = svgDataUrl;
    } catch (e) {
      print('SVG processing error: $e');
      completer.completeError('SVG processing error: $e');
    }

    return completer.future;
  }

  void downloadPng(String pngDataUrl) {
    final anchor = html.AnchorElement(href: pngDataUrl)
      ..target = 'blank'
      ..download = 'converted_image.png';
    anchor.click();
    anchor.remove(); // Clean up
  }
}
