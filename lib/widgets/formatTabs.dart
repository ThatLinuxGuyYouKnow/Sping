import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormatTab extends StatelessWidget {
  final String formatName;

  const FormatTab({super.key, required this.formatName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          formatName,
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
