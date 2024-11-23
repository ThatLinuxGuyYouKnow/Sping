import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  final BoxConstraints constraints;
  Footer({super.key, required this.constraints});
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: constraints.maxWidth,
      height: 80,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Made with ❤️ by',
              style: GoogleFonts.ubuntu(color: Colors.white),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'ThatLinuxGuyYouKnow',
              style: GoogleFonts.ubuntu(
                  decoration: TextDecoration.underline, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
