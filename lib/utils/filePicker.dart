import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

Future<Uint8List?> pickFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'ico', 'tiff'],
  );

  if (result != null) {
    Uint8List fileBytes = result.files.first.bytes!;
    String fileName = result.files.first.name;
    return fileBytes;
  }

  return null;
}
