import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sping/providers/progressProviders.dart';
import 'package:provider/provider.dart';

class FormatTab extends StatelessWidget {
  final String formatName;
  final bool isSelected;
  final VoidCallback onTap;

  const FormatTab({
    super.key,
    required this.formatName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressProvider = Provider.of<ProgressProvider>(context);
    bool originalImageIsSameFromat =
        progressProvider.originalImageFormat.contains(formatName.toLowerCase());
    final Color backgroundColor = isSelected && !originalImageIsSameFromat
        ? Colors.black
        : Colors.transparent;
    final Color textColor = isSelected && !originalImageIsSameFromat
        ? Colors.white
        : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 80,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color:
                originalImageIsSameFromat ? Colors.black : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            formatName,
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
