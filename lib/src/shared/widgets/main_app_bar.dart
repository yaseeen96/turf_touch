import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
            child: FutureBuilder(
                future: const FlutterSecureStorage().read(key: "profile"),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: const LinearProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const CircleAvatar(
                      radius: 40,
                      foregroundImage: AssetImage("assets/sample_profile.jpeg"),
                    );
                  } else if (snapshot.hasData) {
                    return CircleAvatar(
                      radius: 40,
                      foregroundImage: NetworkImage(snapshot.data!),
                    );
                  }
                  return const CircleAvatar(
                    radius: 40,
                    foregroundImage: AssetImage("assets/sample_profile.jpeg"),
                  );
                }),
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: const FlutterSecureStorage().read(key: "name"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: const LinearProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text(
                        "Welcome User",
                        style: CTheme.of(context).theme.subheading,
                      );
                    } else if (snapshot.hasData) {
                      return Text(
                        "Welcome ${snapshot.data}",
                        style: CTheme.of(context).theme.subheading,
                      );
                    }
                    return Text(
                      "Welcome User",
                      style: CTheme.of(context).theme.subheading,
                    );
                  }),
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
              BetterFeedback.of(context).show((UserFeedback feedback) {
                // TODO - Add Feedback
                // Do something with the feedback
              });
            },
            icon: Icon(Icons.feedback)),
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
