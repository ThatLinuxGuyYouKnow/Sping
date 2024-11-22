import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class ConverterScreen extends StatelessWidget {
  ConverterScreen({super.key});

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Column(
              children: [
                Text(
                  'Png To Svg Converter',
                  style: GoogleFonts.ubuntu(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 600,
                  width: screenHeight * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    child: Column(
                      children: [
                        Text('Png'),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.grey.withOpacity(0.01),
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * .05),
                          height: 400,
                          width: screenWidth > 900
                              ? screenWidth * 0.2
                              : screenWidth * 0.4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.04),
                          child: Container(
                            width:
                                screenWidth > 700 ? screenWidth * 0.25 : 2000,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Convert',
                                  style: GoogleFonts.ubuntu(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
