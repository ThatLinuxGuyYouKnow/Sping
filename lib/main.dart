import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sping/converterScreen.dart';
import 'package:flutter_app_icons/flutter_app_icons.dart';

import 'package:sping/providers/progressProviders.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProgressProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        home: const ConverterScreen());
  }
}
