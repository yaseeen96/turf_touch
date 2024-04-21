
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/main/widgets/single_booking_card.dart';

class BookingHistory extends StatelessWidget {
  const BookingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking & History",
            style: CTheme.of(context).theme.heading,
          ),
          const Gap(20),
          const SingleBookingCard(),
          const Gap(20),
          const SingleBookingCard(),
          const Gap(20),
          const SingleBookingCard(),
          const Gap(20),
          const SingleBookingCard(),
          const Gap(20),
        ],
      ),
    );
  }
}
