import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:turf_touch/src/config/theme/app_theme.dart';
import 'package:turf_touch/src/config/theme/custom_theme.dart';
import 'package:turf_touch/src/config/theme/data/dark_theme.dart';
import 'package:turf_touch/src/config/theme/data/light_theme.dart';

class CTheme extends StatefulWidget {
  final Widget child;
  final AppTheme theme;
  const CTheme({Key? key, required this.child, required this.theme})
      : super(key: key);

  static CThemeState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CustomTheme>())!.data;
  }

  @override
  CThemeState createState() => CThemeState();
}

class CThemeState extends State<CTheme> {
  late AppTheme theme;
  late Brightness brightness;

  @override
  void initState() {
    super.initState();
    brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    theme = (brightness == Brightness.dark) ? darkThemeData : lightThemeData;
  }

  void changeTheme() {
    if (theme == lightThemeData) {
      setState(() {
        theme = darkThemeData;
      });
    } else {
      setState(() {
        theme = lightThemeData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTheme(
      data: this,
      theme: widget.theme,
      child: widget.child,
    );
  }
}
