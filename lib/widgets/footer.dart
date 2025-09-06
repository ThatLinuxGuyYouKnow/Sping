import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

class Footer extends StatelessWidget {
  final BoxConstraints constraints;
  final bool isSmallScreen;
  Footer({super.key, required this.constraints, required this.isSmallScreen});
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: constraints.maxWidth,
      height: 70,
      child: Padding(
        padding: isSmallScreen
            ? EdgeInsets.symmetric(horizontal: 8)
            : EdgeInsets.all(0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sping is open source!, leave a star ⭐ ',
                style: GoogleFonts.ubuntu(color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  html.window.open(
                      "https://github.com/ThatLinuxGuyYouKnow/sping",
                      "Source Code");
                },
                child: Text(
                  'Our GitHub',
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
      ),
    );
  }
}
