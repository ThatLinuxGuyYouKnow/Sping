import 'package:flutter/material.dart';

class ProgressProvider extends ChangeNotifier {
  bool _hasPickedAFile = false;
  bool get userHasPickedFile => _hasPickedAFile;
  bool _hasSelectedOutputFormat = false;
  bool get userHasSelectedOutputFormat => _hasSelectedOutputFormat;
  String _originalImageFormat = '';
  String get originalImageFormat => _originalImageFormat;
  bool _userWantsToResizeImage = false;
  bool get userWantsToResizeImage => _userWantsToResizeImage;
  Map<String, String> _imageDimensions = {};
  Map get imageDimensions => imageDimensions;

  setPickedFileStatus(bool status) {
    _hasPickedAFile = status;
    notifyListeners();
  }

  setHasSelectedOutputFormat(bool status) {
    _hasSelectedOutputFormat = status;
    notifyListeners();
  }

  setOriginalImageFormat(String format) {
    _originalImageFormat = format;
    notifyListeners();
  }

  setUserwantsToResizeStatus(bool shouldResize) {
    _userWantsToResizeImage = shouldResize;
    notifyListeners();
  }

  setImageDimensions({required String height, required String width}) {
    _imageDimensions = {'height': height, 'width': width};
    notifyListeners();
  }
}
