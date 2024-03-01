import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/main/features/book_turf/providers/book_turf_providers.dart';

class ChooseDateStepper extends ConsumerStatefulWidget {
  const ChooseDateStepper({super.key});

  @override
  ConsumerState<ChooseDateStepper> createState() => _ChooseDateStepperState();
}

class _ChooseDateStepperState extends ConsumerState<ChooseDateStepper> {
  DateTime? daySelected;
  DateTime focusDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please choose a date for booking",
          style: CTheme.of(context).theme.subheading,
        ),
        TableCalendar(
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(daySelected, day);
          },
          onPageChanged: (focusedDay) {
            focusDay = focusedDay;
          },
          onDaySelected: (selectedDay, focusedDay) {
            ref.read(selectedDateProvider.notifier).state = selectedDay;
            setState(() {
              daySelected = selectedDay;
              focusDay = focusedDay;
            });
          },
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: focusDay,
        ),
      ],
    );
  }
}
