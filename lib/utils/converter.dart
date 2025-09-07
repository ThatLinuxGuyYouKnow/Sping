import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

/* void main() {
  final filePicker =
      html.querySelector('#file-picker') as html.FileUploadInputElement;
  final convertBtn = html.querySelector('#convert-btn') as html.ButtonElement;
  final statusElement = html.querySelector('#status') as html.ParagraphElement;

  convertBtn.onClick.listen((_) async {
    if (filePicker.files!.isEmpty) {
      statusElement.text = 'Please select an SVG file first.';
      return;
    }

    final svgFile = filePicker.files!.first;
    // --- Define your desired output dimensions here ---
    const int desiredWidth = 800;
    const int desiredHeight = 600;

    statusElement.text = 'Converting...';
    convertBtn.disabled = true;

    try {
      // Call the main conversion function
      await convertAndDownloadSvgAsJpg(
        svgFile: svgFile,
        outputWidth: desiredWidth,
        outputHeight: desiredHeight,
        outputFilename: 'converted_image.jpg',
      );
      statusElement.text = 'Conversion successful! Check your downloads.';
    } catch (e) {
      statusElement.text = 'Error: ${e.toString()}';
      print('Conversion failed: $e');
    } finally {
      convertBtn.disabled = false;
    }
  });
}
 */

Future<void> convertAndDownloadSvgAsJpg({
  required html.File svgFile,
  required int outputWidth,
  required int outputHeight,
  required String outputFormat,
  String outputFilename = 'converted.jpg',
}) async {
  final svgContent = await _readSvgFileAsString(svgFile);

  final imageElement = await _svgStringToImageElement(svgContent);

  final jpgDataUrl = createDataUrl(
    outputFormat: outputFormat,
    image: imageElement,
    width: outputWidth,
    height: outputHeight,
  );

  downloadFile(jpgDataUrl, outputFilename);
}

String createDataUrl({
  required String outputFormat,
  required html.ImageElement image,
  required int width,
  required int height,
}) {
  final canvas = html.CanvasElement(width: width, height: height);
  final context = canvas.context2D;

  context.fillStyle = '#FFFFFF';
  context.fillRect(0, 0, width, height);

  context.drawImageScaled(image, 0, 0, width, height);

  final jpgDataUrl = canvas.toDataUrl('image/${outputFormat}', 1.0);
  return jpgDataUrl;
}

Future<String> _readSvgFileAsString(html.File file) {
  final completer = Completer<String>();
  final reader = html.FileReader();
  reader.onLoad.listen((_) {
    completer.complete(reader.result as String);
  });
  reader.onError.listen((_) {
    completer.completeError('Failed to read the file.');
  });
  reader.readAsText(file);
  return completer.future;
}

Future<html.ImageElement> _svgStringToImageElement(String svgContent) {
  final completer = Completer<html.ImageElement>();
  final image = html.ImageElement();

  image.onLoad.listen((_) {
    completer.complete(image);
  });
  image.onError.listen((event) {
    completer.completeError('Could not load SVG string into an image.');
  });

  final svgDataUrl =
      'data:image/svg+xml;base64,${base64Encode(utf8.encode(svgContent.trim()))}';
  image.src = svgDataUrl;

  return completer.future;
}

void downloadFile(String dataUrl, String filename) {
  final anchor = html.AnchorElement(href: dataUrl)
    ..target = 'blank'
    ..download = filename;

  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
