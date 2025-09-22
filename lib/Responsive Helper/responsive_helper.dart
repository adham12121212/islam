// responsive_helper.dart
import 'package:flutter/widgets.dart';

class ResponsiveHelper {
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  static bool isSmallScreen(BuildContext context) => screenWidth(context) < 600;
  static bool isMediumScreen(BuildContext context) => screenWidth(context) >= 600 && screenWidth(context) < 900;
  static bool isLargeScreen(BuildContext context) => screenWidth(context) >= 900;

  // Get responsive font size based on screen width
  static double getResponsiveFontSize(BuildContext context, {double small = 12, double medium = 14, double large = 16}) {
    if (isSmallScreen(context)) return small;
    if (isMediumScreen(context)) return medium;
    return large;
  }

  // Get responsive padding based on screen width
  static EdgeInsets getResponsivePadding(BuildContext context) {
    double padding = isSmallScreen(context) ? 12 : isMediumScreen(context) ? 16 : 20;
    return EdgeInsets.all(padding);
  }

  // Get responsive margin based on screen width
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    double margin = isSmallScreen(context) ? 8 : isMediumScreen(context) ? 12 : 16;
    return EdgeInsets.all(margin);
  }
}