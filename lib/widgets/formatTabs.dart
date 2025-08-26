import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sping/providers/progressProviders.dart';
import 'package:provider/provider.dart';

class FormatTab extends StatelessWidget {
  final String formatName;
  final bool isSelected;
  final VoidCallback? onTap;

  const FormatTab({
    super.key,
    required this.formatName,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressProvider =
        Provider.of<ProgressProvider>(context, listen: false);

    bool isOriginalFormat =
        progressProvider.originalImageFormat == formatName.toLowerCase();

    final Color backgroundColor =
        isSelected && !isOriginalFormat ? Colors.black : Colors.transparent;
    final Color textColor =
        isSelected && !isOriginalFormat ? Colors.white : Colors.black87;
    final Color borderColor =
        isOriginalFormat ? Colors.black : Colors.grey.shade400;

    return GestureDetector(
      onTap: isOriginalFormat ? () {} : onTap,
      child: Container(
        height: 60,
        width: 80,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Opacity(
            opacity: isOriginalFormat ? 0.5 : 1.0,
            child: Text(
              formatName,
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
