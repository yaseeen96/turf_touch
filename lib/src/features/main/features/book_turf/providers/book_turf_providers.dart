import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider = StateProvider<DateTime?>((ref) {
  return null; // Initial value is null, meaning no date is selected initially.
});

final selectedTimeSlotsProvider = StateProvider<List<String>>((ref) {
  return []; // Initial value is an empty list.
});
