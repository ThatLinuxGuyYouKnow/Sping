import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sping/utils/pngTosvgConverter.dart';

class ResponsiveAppBar extends StatelessWidget {
  final bool isDesktop;

  const ResponsiveAppBar({
    super.key,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Image(image: AssetImage('assets/logo.jpg')),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            'SPING',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: isDesktop ? 32 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isDesktop)
          ElevatedButton(
            onPressed: () {
              launchUrlToSite();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.sync_alt,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Convert PNG to SVG here',
                    style:
                        GoogleFonts.ubuntu(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
