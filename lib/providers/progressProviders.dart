import 'package:flutter/material.dart';

class ProgressProvider extends ChangeNotifier {
  bool _hasPickedAFile = false;
  bool get userHasPickedFile => _hasPickedAFile;
  bool _hasSelectedOutputFormat = false;
  bool get userHasSelectedOutputFormat => _hasSelectedOutputFormat;
  String _selectedFromat = '';
  String get userSelectedFromat => _selectedFromat;

  setPickedFileStatus(bool status) {
    _hasPickedAFile = status;
    notifyListeners();
  }

  setHasSelectedOutputFormat(bool status) {
    _hasSelectedOutputFormat = status;
    notifyListeners();
  }

  setUserSeelectedFromat(String format) {
    _selectedFromat = format;
    notifyListeners();
  }
}
