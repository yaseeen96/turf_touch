import 'package:flutter/material.dart';
import 'package:turf_touch/src/config/theme/app_theme.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart'; // Import your custom theme

// Define your custom AppBar widget
class TurfTouchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TurfTouchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: CTheme.of(context).theme.backgroundInverse,
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      surfaceTintColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {
            CTheme.of(context)
                .changeTheme(); // Change the theme when the button is pressed
          },
          icon: Icon(
            // Change the icon based on the current theme
            (CTheme.of(context).theme.cthemeMode == CthemeMode.light)
                ? Icons.wb_sunny
                : Icons.nights_stay,
            color: CTheme.of(context).theme.backgroundInverse,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Set the preferred size
}
