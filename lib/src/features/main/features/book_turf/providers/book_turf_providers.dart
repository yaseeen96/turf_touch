import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:turf_touch/src/features/main/features/book_turf/models/get_packages_response_model.dart';
import 'package:turf_touch/src/features/main/features/book_turf/services/get_packages_service.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';

final selectedDateProvider = StateProvider<DateTime?>((ref) {
  return null; // Initial value is null, meaning no date is selected initially.
});

final selectedTimeSlotsProvider = StateProvider<List<String>>((ref) {
  return []; // Initial value is an empty list.
});

final getPackagesProvider = FutureProvider<double>((ref) async {
  // After fetching the prices, calculate the total price based on selected slots
  double price = 0.0;
  try {
    final prices = await getPackagesService();

    // After fetching the prices, calculate the total price based on selected slots
    final slots = ref.read(selectedTimeSlotsProvider);
    price = calculateTotalPrice(slots, prices.data);
  } on TurfTouchException {
    rethrow;
  }
  return price;
});

double calculateTotalPrice(List<String> slots, List<Data>? pricingData) {
  double totalPrice = 0.0; // Reset total price
  DateTime now = DateTime.now();
  var formatter = DateFormat('E');
  String today = formatter.format(now); // Get today's weekday

  for (var slot in slots) {
    int startHour = int.parse(slot.split('-')[0]);
    bool isWeekend = today == 'Sat' || today == 'Sun';
    bool isMorning = startHour < 12;

    String category;
    if (isWeekend) {
      category = isMorning ? 'Weekends Morning' : 'Weekends Evening';
    } else {
      category = isMorning ? 'Normal Morning' : 'Normal Evening';
    }

    String? price = pricingData
        ?.firstWhere((p) => p.type == category, orElse: () => Data())
        .amount;
    if (price != null) {
      totalPrice += double.parse(price);
    }
  }
  return totalPrice;
}
