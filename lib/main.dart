import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turf_touch/src/config/router/router_config.dart';
import 'package:turf_touch/src/config/theme/data/light_theme.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

void main() {
  runApp(
    ProviderScope(
      child: CTheme(
        theme: lightThemeData,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      debugShowCheckedModeBanner: false,
      title: 'Turf Touch Application',
      routerConfig: goRouterConfig,
    );
  }
}
