import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final BoxConstraints constraints;
  Footer({super.key, required this.constraints});
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: constraints.maxWidth,
      height: 80,
    );
  }
}
