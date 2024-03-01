import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: CTheme.of(context).theme.primaryColor,
            radius: 80,
            child: Icon(
              Icons.notifications,
              size: 80,
              color: Colors.white,
            ),
          ),
          const Gap(20),
          Text(
            "No Notifications Yet",
            style: CTheme.of(context).theme.subheading,
          )
        ],
      ),
    );
  }
}
