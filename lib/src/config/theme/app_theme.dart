import 'package:flutter/material.dart';

enum CthemeMode { light, dark }

class AppTheme {
  final Color backgroundColor;
  final Color backgroundInverse;
  final Color primaryColor;
  final Color accentColor;
  final TextStyle bodyText;
  final TextStyle heading;
  final TextStyle subheading;
  final TextStyle label;
  final CthemeMode cthemeMode;
  final ButtonStyle buttonStyle;

  AppTheme({
    required this.backgroundColor,
    required this.primaryColor,
    required this.accentColor,
    required this.bodyText,
    required this.heading,
    required this.subheading,
    required this.cthemeMode,
    required this.backgroundInverse,
    required this.label,
    required this.buttonStyle,
  });
}
