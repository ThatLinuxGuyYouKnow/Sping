import 'package:flutter/material.dart';
import 'package:sping/converterScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.Well duh?
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "SPING: SVG to PNG converter",
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: ConverterScreen());
  }
}
