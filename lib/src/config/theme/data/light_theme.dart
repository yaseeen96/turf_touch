import 'package:flutter/material.dart';
import 'package:turf_touch/src/config/theme/app_theme.dart';

final lightThemeData = AppTheme(
    backgroundInverse: Colors.black,
    cthemeMode: CthemeMode.light,
    backgroundColor: Colors.white,
    primaryColor: Colors.red,
    accentColor: Colors.amber,
    bodyText: const TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    heading: const TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    subheading: const TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    label: TextStyle(color: Colors.grey[700], fontSize: 15));
