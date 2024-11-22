import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class SvgToPngConverter {
  final String svgContent;
  final String? scaleHeight;
  final String? scaleWidth;
  SvgToPngConverter(this.svgContent, this.scaleHeight, this.scaleWidth);

  Future<void> convertSvgToPng() async {
    try {
      // Create an SVG element in the browser
      final svgElement = html.ImageElement();
      // Set explicit dimensions if not already set
      svgElement.style.width = scaleWidth;
      svgElement.style.height = scaleHeight;

      // Create a canvas element with appropriate dimensions
      final canvasElement = html.CanvasElement(
        width: svgElement.clientWidth ?? 500,
        height: svgElement.clientHeight ?? 500,
      );
      final context = canvasElement.context2D;

      // Draw SVG onto the canvas
      final image = await _svgToImage(svgElement);
      context.drawImageScaled(
        image,
        0,
        0,
        canvasElement.width!,
        canvasElement.height!,
      );

      // Convert canvas to PNG data URL
      final pngDataUrl = canvasElement.toDataUrl('image/png');

      // Trigger a download in the browser
      _downloadPng(pngDataUrl);
    } catch (e) {
      print('Conversion error: $e');
    }
  }

  Future<html.ImageElement> _svgToImage(html.ImageElement svgElement) async {
    final completer = Completer<html.ImageElement>();
    final img = html.ImageElement();

    img.onLoad.listen((_) => completer.complete(img));
    img.onError.listen((error) => completer.completeError('Image load error'));

    // Convert SVG to data URL
    final svgDataUrl =
        'data:image/svg+xml;base64,${base64Encode(utf8.encode(svgElement.outerHtml!))}';
    img.src = svgDataUrl;

    return completer.future;
  }

  void _downloadPng(String pngDataUrl) {
    final anchor = html.AnchorElement(href: pngDataUrl)
      ..target = 'blank'
      ..download = 'converted_image.png';
    anchor.click();
    anchor.remove(); // Clean up
  }
}
