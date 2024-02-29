import 'package:flutter/material.dart';
import 'package:turf_touch/src/config/theme/app_theme.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

class CustomTheme extends InheritedWidget {
  const CustomTheme({
    Key? key,
    required this.child,
    required this.data,
    required this.theme,
  }) : super(key: key, child: child);

  // ignore: annotate_overrides, overridden_fields
  final Widget child;
  final CThemeState data;
  final AppTheme theme;

  @override
  bool updateShouldNotify(CustomTheme oldWidget) => true;
}
