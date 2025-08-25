import 'package:flutter/material.dart';

class ProgressProvider extends ChangeNotifier {
  bool _hasPickedAFile = false;
  bool get userHasPickedFile => _hasPickedAFile;
  bool _hasSelectedOutputFormat = false;
  bool get userHasSelectedOutputFormat => _hasSelectedOutputFormat;
  String _originalImageFormat = '';
  String get originalImageFormat => _originalImageFormat;

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
}
