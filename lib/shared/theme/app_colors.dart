import 'package:flutter/material.dart';

class AppColors {
  // Primary Blue Colors
  /// Primary Blue: blue-600 (#2563eb) - Main brand color for buttons and interactive elements
  static const Color primary = Color(0xff2563eb);

  /// Dark Blue: blue-900 (#1e3a8a) - For headings and important text
  static const Color secondary = Color(0xff1e3a8a);

  /// Light Blue: blue-50 (#eff6ff) - Light blue backgrounds for sections
  static const Color background = Color(0xffeff6ff);

  /// Medium Blue: blue-700 (#1d4ed8) - Hover states and secondary actions
  static const Color accent = Color(0xff1d4ed8);

  // Additional Blue Shades
  /// Blue-100 for very light backgrounds
  static const Color surfaceLight = Color(0xffdbeafe);

  /// Blue-200 for borders and dividers
  static const Color primaryBorder = Color(0xffbfdbfe);

  /// Blue-300 for disabled states
  static const Color secondaryBorder = Color(0xff93c5fd);

  /// Blue-400 for secondary text
  static const Color lightGrey = Color(0xff60a5fa);

  /// Blue-500 for medium emphasis
  static const Color tertiary = Color(0xff3b82f6);

  /// Blue-800 for dark text
  static const Color darkText = Color(0xff1e40af);

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
  static const Color blue = primary;
}
