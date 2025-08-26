import 'dart:typed_data';
import 'dart:ui';

import 'package:image/image.dart' as img;

Future<Size?> getImageSizeFromBytes(Uint8List bytes) async {
  final image = img.decodeImage(bytes);

  if (image != null) {
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  return null;
}
