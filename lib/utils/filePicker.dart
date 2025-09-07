import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<Map<String, dynamic>?> pickFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'ico', 'tiff', 'svg'],
      withData: true);

  if (result != null) {
    Uint8List fileBytes = result.files.first.bytes!;
    String fileName = result.files.first.name;
    String? fileExtension = result.files.first.extension;
    bool isSVG = fileExtension == 'svg';

    return {
      'bytes': fileBytes,
      'name': fileName,
      'extension': fileExtension,
      'file': isSVG ? result.files.first : null
    };
  }

  return null;
}
