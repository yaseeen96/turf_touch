import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/constants/time_slots.dart';
import 'package:turf_touch/src/features/main/features/book_turf/providers/book_turf_providers.dart';

class SelectTimeStepper extends ConsumerStatefulWidget {
  const SelectTimeStepper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectTimeStepperState();
}

class _SelectTimeStepperState extends ConsumerState<SelectTimeStepper> {
  void _onTimeSlotSelected(bool selected, String timeSlot) {
    final currentSelected = ref.read(selectedTimeSlotsProvider.notifier).state;
    if (selected) {
      currentSelected.add(timeSlot);
    } else {
      currentSelected.remove(timeSlot);
    }
    ref.read(selectedTimeSlotsProvider.notifier).state =
        List.from(currentSelected); // Update the global state
  }

  String convertTo12HourFormat(String timeSlot) {
    return timeSlot.split('-').map((time) {
      int hour = int.parse(time);
      String suffix = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      if (hour == 0) hour = 12; // Handle midnight and noon
      return "$hour $suffix";
    }).join(' - ');
  }

  @override
  Widget build(BuildContext context) {
    // TODO - call API and remove time slots which are booked
    final selectedDate = ref.watch(selectedDateProvider);
    List<String> selectedTimeSlots = ref.watch(selectedTimeSlotsProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: ListView(
        physics: const ScrollPhysics(),
        children: [
          ...timeSlots.map((timeSlot) => CheckboxListTile(
                title: Text(
                  convertTo12HourFormat(timeSlot),
                  style: CTheme.of(context).theme.bodyText,
                ),
                value: selectedTimeSlots.contains(timeSlot),
                onChanged: (bool? value) {
                  _onTimeSlotSelected(value!, timeSlot);
                },
              ))
        ],
      ),
    );
  }
}
