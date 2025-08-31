import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sping/widgets/confirmDownloadDialog.dart';

import 'dart:html' as html;

Future<bool> downloadFile(Uint8List bytes, {required String fileName}) async {
  try {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..style.display = 'none';

    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);

    await Future.delayed(const Duration(milliseconds: 100));

    html.Url.revokeObjectUrl(url);
    return true;
  } catch (e) {
    print('Download failed: $e');
    return false;
  }
}

Future<void> downloadWithFeedback(
  BuildContext context,
  Uint8List bytes,
  String fileName,
) async {
  final success = await downloadFile(bytes, fileName: fileName);

  if (success) {
    // Show success dialog
    await ConfirmDownloadDialog(context);
  } else {
    // Show error toast
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Download failed. Please check your browser settings or disable ad blockers.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Retry',
            textColor: Colors.white,
            onPressed: () => downloadWithFeedback(context, bytes, fileName),
          ),
        ),
      );
    }
  }
}
