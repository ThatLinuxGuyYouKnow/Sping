import 'package:flutter/material.dart';

void buildErrorSnackbar(context, String errorText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorText),
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
