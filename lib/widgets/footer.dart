import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

class Footer extends StatelessWidget {
  final BoxConstraints constraints;
  Footer({super.key, required this.constraints});
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: constraints.maxWidth,
      height: 70,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Made with ❤️ by',
              style: GoogleFonts.ubuntu(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                html.window.open(
                    "https://github.com/ThatLinuxGuyYouKnow?tab=repositories",
                    "Theos message to you");
              },
              child: Text(
                'ThatLinuxGuyYouKnow',
                style: GoogleFonts.ubuntu(
                    decoration: TextDecoration.underline,
                    decorationColor:
                        Colors.white, // This makes the underline white
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
