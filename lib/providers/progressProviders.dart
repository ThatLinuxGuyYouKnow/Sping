import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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
  Map<String, String> get imageDimensions => _imageDimensions;
  Uint8List? get imageBytes => _imageBytes;
  Uint8List? _imageBytes;
  String _originalFilename = '';
  String _outputFormat = '';
  String get outputFormat => _outputFormat;
  bool get startedDownloadProcess => _startedDownloadProcess;
  bool _startedDownloadProcess = true;
  bool get isSvgFile => _svgFile;
  bool _svgFile = false;
  String get originalFileName => _originalFilename;
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

  setImageBytes(Uint8List imageBytes) {
    _imageBytes = imageBytes;
    notifyListeners();
  }

  setOriginalFileName({required String filename}) {
    _originalFilename = filename;
    notifyListeners();
  }

  setOutputFormat({required String outputFormat}) {
    _outputFormat = outputFormat;
    notifyListeners();
  }

  setsvgFile(bool isSvg) {
    _svgFile = isSvg;
    notifyListeners();
  }

  notifyDownloadDone() {
    _startedDownloadProcess = true;
    notifyListeners();
  }
}
