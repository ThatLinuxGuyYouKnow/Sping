import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sping/providers/progressProviders.dart';

class FileTab extends StatelessWidget {
  FileTab({super.key, required this.selectedFileName});

  final String selectedFileName;

  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            color: Colors.grey.shade600,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              selectedFileName,
              style: GoogleFonts.ubuntu(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.black,
            ),
            onPressed: () {
              progressProvider.setPickedFileStatus(false);
            },
          ),
        ],
      ),
    );
  }
}
