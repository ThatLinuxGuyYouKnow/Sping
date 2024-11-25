import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

class SvgToPngConverter {
  final String svgContent;
  final int? scaleWidthBy;
  final int? scaleHeightBy;

  SvgToPngConverter({
    required this.svgContent,
    this.scaleWidthBy,
    this.scaleHeightBy,
  });

  Future<String> convertSvgToPng() async {
    try {
      // Load the SVG image to get original dimensions
      final image = await _svgToImage();

      // Get original dimensions
      final originalWidth = image.naturalWidth;
      final originalHeight = image.naturalHeight;

      // Calculate scaled dimensions
      final width = scaleWidthBy != null
          ? (originalWidth * scaleWidthBy!).toInt()
          : originalWidth;
      final height = scaleHeightBy != null
          ? (originalHeight * scaleHeightBy!).toInt()
          : originalHeight;

      print('Original dimensions: $originalWidth x $originalHeight');
      print('Scaled dimensions: $width x $height');

      // Create canvas with scaled dimensions
      final canvasElement = html.CanvasElement(
        width: width,
        height: height,
      );
      final context = canvasElement.context2D;

      // Clear the canvas first
      context.clearRect(0, 0, width, height);

      // Calculate aspect ratio and scaling
      final svgAspectRatio = originalWidth / originalHeight;
      final canvasAspectRatio = width / height;

      double scaledWidth, scaledHeight;

      // Determine scaling strategy to maintain aspect ratio
      if (canvasAspectRatio > svgAspectRatio) {
        // Canvas is wider relative to its height
        scaledHeight = height.toDouble();
        scaledWidth = height * svgAspectRatio;
      } else {
        // Canvas is taller relative to its width
        scaledWidth = width.toDouble();
        scaledHeight = width / svgAspectRatio;
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

  Future<html.ImageElement> _svgToImage() async {
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

  void downloadPng(String pngDataUrl, int scale) {
    final anchor = html.AnchorElement(href: pngDataUrl)
      ..target = 'blank'
      ..download = 'converted_image.png';
    anchor.click();
    anchor.remove(); // Clean up
  }
}
