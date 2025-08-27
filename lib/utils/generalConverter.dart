import 'package:image/image.dart' as img;
import 'dart:typed_data';

Future<Uint8List?> convertImageFormat(
    Uint8List inputBytes, String imageOutputFormat,
    {int jpegQuality = 85}) async {
  try {
    img.Image? image = img.decodeImage(inputBytes);

    if (image == null) {
      print('Failed to decode image');
      return null;
    }

    List<int> outputBytes;

    switch (imageOutputFormat) {
      case 'png':
        outputBytes = img.encodePng(image);
        break;
      case 'jpeg':
        outputBytes = img.encodeJpg(image, quality: jpegQuality);
        break;
      case 'bmp':
        outputBytes = img.encodeBmp(image);
        break;
      case 'tiff':
        outputBytes = img.encodeTiff(image);
        break;
      case 'gif':
        outputBytes = img.encodeGif(image);
        break;
      case 'ico':
        outputBytes = img.encodeIco(image);
        break;
      case 'tga':
        outputBytes = img.encodeTga(image);
        break;

      default:
        throw UnsupportedError('Unsupported image format: $imageOutputFormat');
    }

    return Uint8List.fromList(outputBytes);
  } catch (e) {
    print('Error converting image: $e');
    return null;
  }
}
