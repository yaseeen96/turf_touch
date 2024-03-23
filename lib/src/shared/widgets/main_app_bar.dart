import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/app_theme.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/profile/providers/get_profile_provider.dart';
import 'package:turf_touch/src/shared/providers/name_provider.dart'; // Import your custom theme

// Define your custom AppBar widget
class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: double.infinity,
      foregroundColor: CTheme.of(context).theme.backgroundInverse,
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context.push("/profile");
              },
              child: FutureBuilder(
                  future: ref.read(getProfileProvider.future),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasError) {
                      return const CircleAvatar(
                        radius: 30,
                        foregroundImage:
                            AssetImage("assets/sample_profile.jpeg"),
                      );
                    } else if (snapshot.hasData) {
                      return CircleAvatar(
                        radius: 30,
                        foregroundImage: NetworkImage(snapshot.data!.profile!),
                      );
                    }
                    return const CircleAvatar(
                      radius: 30,
                      foregroundImage: AssetImage("assets/sample_profile.jpeg"),
                    );
                  }),
            ),
          ),
          const Gap(10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(
                  builder: (context, ref, child) => FutureBuilder(
                      future: ref.watch(fullNameProvider.future),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: const LinearProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text(
                            "Welcome User",
                            style: CTheme.of(context).theme.subheading,
                          );
                        } else if (snapshot.hasData) {
                          return FittedBox(
                            child: Text(
                              "Welcome ${snapshot.data}",
                              style: CTheme.of(context).theme.subheading,
                            ),
                          );
                        }
                        return Text(
                          "Welcome User",
                          style: CTheme.of(context).theme.subheading,
                        );
                      }),
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
            ),
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
