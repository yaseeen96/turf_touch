import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/constants/time_slots.dart';
import 'package:turf_touch/src/features/main/features/book_turf/providers/book_turf_providers.dart';
import 'package:turf_touch/src/features/main/features/book_turf/services/get_booked_slots.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';

class SelectTimeStepper extends ConsumerStatefulWidget {
  const SelectTimeStepper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectTimeStepperState();
}

class _SelectTimeStepperState extends ConsumerState<SelectTimeStepper> {
  @override
  void didChangeDependencies() {
    fetchBookedSlots();
    super.didChangeDependencies();
  }

  List<String> bookedSlots = [];
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

  void fetchBookedSlots() async {
    try {
      final response =
          await getBookedSlotsService(date: ref.read(selectedDateProvider)!);
      setState(() {
        bookedSlots = response.slots ?? [];
      });
    } on TurfTouchException catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This ensures fetchBookedSlots is called after the widget is fully built,
      // so the context and providers are properly initialized.
      fetchBookedSlots();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO - call API and remove time slots which are booked
    final selectedDate = ref.watch(selectedDateProvider);
    List<String> selectedTimeSlots = ref.watch(selectedTimeSlotsProvider);
    List<String> availableTimeSlots =
        timeSlots.where((slot) => !bookedSlots.contains(slot)).toList();
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: availableTimeSlots.length, // Use count of availableTimeSlots
        itemBuilder: (context, index) {
          String timeSlot =
              availableTimeSlots[index]; // Use availableTimeSlots for listing
          return CheckboxListTile(
            title: Text(
              convertTo12HourFormat(timeSlot),
              style: CTheme.of(context).theme.bodyText,
            ),
            value: selectedTimeSlots.contains(timeSlot),
            onChanged: (bool? value) {
              _onTimeSlotSelected(value!, timeSlot);
            },
          );
        },
      ),
    );
  }
}
