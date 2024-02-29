import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/app_theme.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart'; // Import your custom theme

// Define your custom AppBar widget
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: double.infinity,
      foregroundColor: CTheme.of(context).theme.backgroundInverse,
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          InkWell(
            onTap: () {
              context.push("/profile");
            },
            child: const CircleAvatar(
              radius: 40,
              foregroundImage: AssetImage("assets/sample_profile.jpeg"),
            ),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Yaseen",
                style: CTheme.of(context).theme.subheading,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  Text(
                    "Gulbarga",
                    style: CTheme.of(context).theme.bodyText,
                  ),
                ],
              )
            ],
          )
        ],
      ),
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
      const Size.fromHeight(100); // Set the preferred size
}
