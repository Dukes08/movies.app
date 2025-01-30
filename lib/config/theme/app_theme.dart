import 'package:flutter/material.dart';

// This class is responsible for defining and providing the application's theme.
class AppTheme {
  // The `getTheme` method returns a ThemeData object that defines the app's appearance.
  ThemeData getTheme() => ThemeData(
        // `colorSchemeSeed` is used to generate a color scheme based on a seed color.
        // The color provided here is a shade of blue.
        colorSchemeSeed: const Color(0xff2862f5),
      );
}
