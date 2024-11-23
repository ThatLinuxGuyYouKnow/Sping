import 'package:flutter/material.dart';
import 'package:sping/converterScreen.dart';
import 'package:flutter_app_icons/flutter_app_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.Well duh?
  @override
  Widget build(BuildContext context) {
    final _flutterAppIconsPlugin = FlutterAppIcons();
    _flutterAppIconsPlugin.setIcon(
        icon:
            'favicon.png'); //REMINDER: FIXED FAVICON ISSUE ON NETLFIY BY MAUALLY CHANGING IT IN WEB/
    return MaterialApp(
        title: "SPING: SVG to PNG converter",
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: ConverterScreen());
  }
}
