import 'package:flutter/material.dart';

class Helper {

  /// Retrieve Image widget from label string
  static Image getImage(String label) {
    var filePath = "icons/" + label.toLowerCase().replaceAll(" ", "_") + ".png";
    return Image.asset(
        filePath,
        height: 40,
      );
  }
}