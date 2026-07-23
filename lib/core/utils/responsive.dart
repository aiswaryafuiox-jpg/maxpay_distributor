import 'package:flutter/material.dart';

class Responsive {
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1024;

  static double getWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 600) {
      return 500.0; // Max width for tablet content
    }
    return width;
  }
}
