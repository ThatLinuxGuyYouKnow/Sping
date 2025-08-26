import 'dart:async';

import 'dart:ui';

import 'package:flutter/material.dart';

Future<Size> getImageSize(ImageProvider imageProvider) async {
  final ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
  final Completer<Size> completer = Completer<Size>();

  late ImageStreamListener listener;
  listener = ImageStreamListener((ImageInfo info, bool synchronousCall) {
    final Size size = Size(
      info.image.width.toDouble(),
      info.image.height.toDouble(),
    );
    completer.complete(size);
    stream.removeListener(listener);
  });

  stream.addListener(listener);
  return completer.future;
}
