import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/constants/random_bookings.dart';

class SingleBookingCard extends StatelessWidget {
  const SingleBookingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CTheme.of(context).theme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color:
                  CTheme.of(context).theme.backgroundInverse.withOpacity(0.2),
              offset: Offset.fromDirection(360),
              spreadRadius: 2,
              blurRadius: 4),
        ],
      ),
      width: double.infinity,
      height: 150,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(randomBookingImages[
                          Random().nextInt(randomBookingImages.length)])),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
            ),
          ),
          Gap(10),
          Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: CTheme.of(context).theme.backgroundColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Text(
                    "29 February 2024",
                    style: CTheme.of(context).theme.subheading,
                  ),
                  const Gap(5),
                  Text(
                    "6:00 AM to 10:00 AM",
                    style: CTheme.of(context)
                        .theme
                        .bodyText
                        .copyWith(fontSize: 10),
                  ),
                  const Gap(15),
                  Text(
                    "₹600",
                    style: CTheme.of(context).theme.heading.copyWith(
                          color: CTheme.of(context).theme.primaryColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
