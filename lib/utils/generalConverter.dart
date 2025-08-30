import 'package:image/image.dart' as img;
import 'dart:typed_data';

Future<Uint8List?> convertAndResizeImage(
  Uint8List inputBytes,
  String outputFormat, {
  int? targetWidth,
  int? targetHeight,
  int jpegQuality = 85,
  img.Interpolation interpolation = img.Interpolation.linear,
}) async {
  try {
    img.Image? image = img.decodeImage(inputBytes);

    if (image == null) {
      print('Failed to decode image');
      return null;
    }

    if (targetWidth != null || targetHeight != null) {
      image = _resizeImage(image, targetWidth, targetHeight, interpolation);
    }

    List<int> outputBytes;

    switch (outputFormat) {
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
        throw ('Unknownimage format');
    }
    print('Succefully resized');
    return Uint8List.fromList(outputBytes);
  } catch (e) {
    print('Error converting/resizing image: $e');
    return null;
  }
}

img.Image _resizeImage(
  img.Image image,
  int? targetWidth,
  int? targetHeight,
  img.Interpolation interpolation,
) {
  if (targetWidth != null && targetHeight != null) {
    return img.copyResize(
      image,
      width: targetWidth,
      height: targetHeight,
      interpolation: interpolation,
    );
  } else if (targetWidth != null) {
    return img.copyResize(
      image,
      width: targetWidth,
      interpolation: interpolation,
    );
  } else if (targetHeight != null) {
    return img.copyResize(
      image,
      height: targetHeight,
      interpolation: interpolation,
    );
  }

  return image;
}
