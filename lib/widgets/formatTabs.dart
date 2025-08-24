import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormatTab extends StatefulWidget {
  final String formatName;

  const FormatTab({super.key, required this.formatName});

  @override
  State<FormatTab> createState() => _FormatTabState();
}

class _FormatTabState extends State<FormatTab> {
  bool isTileTaped = false;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTileTaped = !isTileTaped;
        });
      },
      child: Container(
        color: isTileTaped ? Colors.transparent : Colors.black,
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
            widget.formatName,
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w500,
              color: isTileTaped ? Colors.black87 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
