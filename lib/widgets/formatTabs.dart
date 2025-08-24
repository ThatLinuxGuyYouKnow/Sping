import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormatTab extends StatelessWidget {
  final String formatName;
  FormatTab({super.key, required this.formatName});

  Widget build(BuildContext context) {
    return Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          formatName,
          style: GoogleFonts.ubuntu(),
        ));
  }
}
