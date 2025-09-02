import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logoscreen extends StatelessWidget {
  Logoscreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.jpg'),
              Text(
                'SPING',
                style: GoogleFonts.ubuntu(
                    fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
