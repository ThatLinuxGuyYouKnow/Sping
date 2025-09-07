import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

getSvgDimensions({required Uint8List imageBytes}) async {
  final svgContent = utf8.decode(imageBytes);

  final imageElement = await _svgStringToImageElement(svgContent);

  final height = imageElement.naturalHeight;
  final width = imageElement.naturalWidth;

  return {'height': height, 'width': width};
}

Future<void> convertAndDownloadSvg({
  required Uint8List svgBytes,
  required int outputWidth,
  required int outputHeight,
  required String outputFormat,
}) async {
  final svgContent = utf8.decode(svgBytes);

  final imageElement = await _svgStringToImageElement(svgContent);

  final dataUrl = _createDataUrl(
    image: imageElement,
    width: outputWidth,
    height: outputHeight,
    format: outputFormat,
  );

  final outputFilename = 'converted_image.${outputFormat.toLowerCase()}';

  _downloadFile(dataUrl, outputFilename);
}

String _createDataUrl({
  required html.ImageElement image,
  required int width,
  required int height,
  required String format,
}) {
  final canvas = html.CanvasElement(width: width, height: height);
  final context = canvas.context2D;

  context.fillStyle = '#FFFFFF';
  context.fillRect(0, 0, width, height);
  context.drawImageScaled(image, 0, 0, width, height);

  String mimeType = 'image/${format.toLowerCase()}';
  if (format.toUpperCase() == 'JPG') {
    mimeType = 'image/jpeg';
  }

  return canvas.toDataUrl(mimeType, 1.0);
}

Future<html.ImageElement> _svgStringToImageElement(String svgContent) {
  final completer = Completer<html.ImageElement>();
  final image = html.ImageElement();

  image.onLoad.listen((_) => completer.complete(image));
  image.onError
      .listen((_) => completer.completeError('Could not load SVG string.'));

  final svgDataUrl =
      'data:image/svg+xml;base64,${base64Encode(utf8.encode(svgContent.trim()))}';
  image.src = svgDataUrl;

  return completer.future;
}

void _downloadFile(String dataUrl, String filename) {
  final anchor = html.AnchorElement(href: dataUrl)
    ..target = 'blank'
    ..download = filename;
  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
