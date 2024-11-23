import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  final BoxConstraints constraints;

  // Proper constructor naming convention in Dart is capitalized
  const Footer({super.key, required this.constraints});

  bool get isDesktop => constraints.maxWidth > 900;
  bool get isTablet =>
      constraints.maxWidth > 600 && constraints.maxWidth <= 900;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.05,
          vertical: 40,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SVG to PNG Converter',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Convert your SVG files to high-quality PNG images\nwith customizable scaling options.',
                        style: GoogleFonts.ubuntu(
                          color: Colors.grey[400],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isDesktop) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resources',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _FooterLink('Documentation'),
                        _FooterLink('API Reference'),
                        _FooterLink('Support'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Legal',
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _FooterLink('Privacy Policy'),
                        _FooterLink('Terms of Service'),
                        _FooterLink('Cookie Policy'),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            if (!isDesktop) ...[
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resources',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _FooterLink('Documentation'),
                      _FooterLink('API Reference'),
                      _FooterLink('Support'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Legal',
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _FooterLink('Privacy Policy'),
                      _FooterLink('Terms of Service'),
                      _FooterLink('Cookie Policy'),
                    ],
                  ),
                ],
              ),
            ],
            const SizedBox(height: 40),
            Text(
              '© ${DateTime.now().year} SVG to PNG Converter. All rights reserved.',
              style: GoogleFonts.ubuntu(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;

  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            // Add navigation logic here
          },
          child: Text(
            text,
            style: GoogleFonts.ubuntu(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
