import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScaleTextFields extends StatelessWidget {
  final bool isDesktop;
  final String hintText;
  ScaleTextFields({super.key, required this.isDesktop, required this.hintText});

  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: hintText, hintStyle: GoogleFonts.ubuntu()),
          ),
          Text(
            'px',
            style: GoogleFonts.ubuntu(),
          )
        ],
      ),
    );
  }
}
