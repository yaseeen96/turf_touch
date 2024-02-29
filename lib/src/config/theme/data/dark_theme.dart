import 'package:flutter/material.dart';
import 'package:turf_touch/src/config/theme/app_theme.dart';

final darkThemeData = AppTheme(
  backgroundInverse: Colors.white,
  cthemeMode: CthemeMode.dark,
  backgroundColor: Colors.black,
  primaryColor: Colors.red,
  accentColor: Colors.amber,
  bodyText: const TextStyle(
    color: Colors.white,
    fontSize: 14,
  ),
  heading: const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ),
  subheading: const TextStyle(
    color: Colors.white,
    fontSize: 18,
  ),
  label: TextStyle(
    color: Colors.grey[400],
    fontSize: 15,
  ),
  buttonStyle: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
