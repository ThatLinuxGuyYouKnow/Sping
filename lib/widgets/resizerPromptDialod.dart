import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget resizerDialog() {
  return Dialog(
    child: Container(
        height: 100,
        width: 180,
        child: Column(
          children: [
            Text(
              'Do you need to resize this image?',
              style: GoogleFonts.ubuntu(),
            )
          ],
        )),
  );
}
