import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder instead of direct MediaQuery for better responsiveness
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive values based on constraints
        final isDesktop = constraints.maxWidth > 900;
        final isTablet =
            constraints.maxWidth > 600 && constraints.maxWidth <= 900;
        final isMobile = constraints.maxWidth <= 600;

        // Calculate container width based on screen size
        final containerWidth = isDesktop
            ? constraints.maxWidth * 0.4
            : isTablet
                ? constraints.maxWidth * 0.6
                : constraints.maxWidth * 0.85;

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.black,
            title: ResponsiveAppBar(isDesktop: isDesktop),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.05,
                vertical: 20,
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      width: containerWidth,
                      constraints: const BoxConstraints(
                        minHeight: 400,
                        maxHeight: 600,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PNG',
                              style: GoogleFonts.ubuntu(
                                fontSize: isDesktop ? 24 : 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 24,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.grey.withOpacity(0.01),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            ConvertButton(
                              width: isDesktop
                                  ? containerWidth * 0.4
                                  : containerWidth * 0.8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

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
        Expanded(
          child: Text(
            'PNG To SVG Converter',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: isDesktop ? 32 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isDesktop)
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Convert SVG to PNG here',
              style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          ),
      ],
    );
  }
}

class ConvertButton extends StatelessWidget {
  final double width;

  const ConvertButton({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Convert',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
