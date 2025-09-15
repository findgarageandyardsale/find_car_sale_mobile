import 'package:flutter/material.dart';

class AppColors {
  // Primary Red Colors
  /// Primary Red: red-600 (#dc2626) - Main brand color for buttons and interactive elements
  static const Color primary = Color(0xffdc2626);

  /// Dark Red: red-900 (#7f1d1d) - For headings and important text
  static const Color secondary = Color(0xff7f1d1d);

  /// Light Red: red-50 (#fef2f2) - Light red backgrounds for sections
  static const Color background = Color(0xfffef2f2);

  /// Medium Red: red-700 (#b91c1c) - Hover states and secondary actions
  static const Color accent = Color(0xffb91c1c);

  // Additional Red Shades
  /// Red-100 for very light backgrounds
  static const Color surfaceLight = Color(0xfffecaca);

  /// Red-200 for borders and dividers
  static const Color primaryBorder = Color(0xfffca5a5);

  /// Red-300 for disabled states
  static const Color secondaryBorder = Color(0xfff87171);

  /// Red-400 for secondary text
  static const Color lightGrey = Color(0xfff87171);

  /// Red-500 for medium emphasis
  static const Color tertiary = Color(0xffef4444);

  /// Red-800 for dark text
  static const Color darkText = Color(0xff991b1b);

  // Purple Colors for Gradients
  /// Purple-600 for gradients
  static const Color purple = Color(0xff9333ea);

  /// Purple-700 for gradient accents
  static const Color purpleAccent = Color(0xff7c3aed);

  // Status Colors
  /// Green-500 for success indicators and status dots
  static const Color green = Color(0xff10b981);

  /// Yellow for star ratings and highlights
  static const Color yellow = Color(0xfff59e0b);

  /// Error color
  static const Color error = Color(0xffef4444);

  // Neutral Colors
  /// App black color
  static const Color black = Color(0xff14171A);

  /// App white color
  static const Color white = Color(0xffffffff);

  /// Extra Light grey color
  static const Color extraLightGrey = Color(0xfff8fafc);

  /// Surface color for dark theme
  static const Color surface = Color(0xff0f172a);

  /// Tile color
  static const Color tileColor = Color(0xff64748b);

  /// Disabled text color
  static const Color disabledTextColor = Color(0xff94a3b8);

  /// Unselected text color
  static const Color unselectedTextColor = Color(0xff64748b);

  // Legacy color mappings for backward compatibility
  static const Color primaryContainer = background;
  static const Color secondaryContainer = surfaceLight;
  static const Color surfaceContainer = primaryBorder;
  static const Color surfaceContainerLow = background;
  static const Color softColor = background;
  static const Color lightPrimaryColor = surfaceLight;
  static const Color blue =
      primary; // Now red, but keeping name for compatibility
}
