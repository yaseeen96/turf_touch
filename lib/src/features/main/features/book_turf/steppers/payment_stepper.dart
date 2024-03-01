import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/main/features/book_turf/models/get_packages_response_model.dart';
import 'package:turf_touch/src/features/main/features/book_turf/providers/book_turf_providers.dart';
import 'package:turf_touch/src/features/main/features/book_turf/services/get_packages_service.dart';
import 'package:turf_touch/src/features/main/features/payment/providers/payment_providers.dart';
import 'package:turf_touch/src/features/main/features/payment/services/create_order_service.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';
import 'package:turf_touch/src/shared/helpers/convert_to_12.dart';
import 'package:turf_touch/src/shared/widgets/top_snackbar.dart';

class PaymentStepper extends ConsumerStatefulWidget {
  const PaymentStepper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentStepperState();
}

class _PaymentStepperState extends ConsumerState<PaymentStepper> {
  late GetPackagesResponseModel prices;
  late double totalPrice;
  bool payOnSpot = false;
  bool razorPay = false;

  void getPackages() async {
    try {
      prices = await getPackagesService();
      // After fetching the prices, calculate the total price based on selected slots
      final slots = ref.read(selectedTimeSlotsProvider);
      calculateTotalPrice(slots, prices.data);
    } on TurfTouchException catch (err) {
      if (!context.mounted) {
        return;
      }
      getSnackBar(context: context, message: err.message);
    }
  }

  String formatSelectedSlots(List<String> slots) {
    // Convert each slot to 12-hour format and join with a comma and a space
    return slots.map((slot) => convertTo12HourFormat(slot)).join(', ');
  }

  void onPaymentPress() async {
    if (razorPay) {
      // Place order from API
      try {
        // Assuming totalPrice is a double, convert it to paise by multiplying by 100
        final int amountInRupees = totalPrice.toInt();
        print("Amount in paise: $amountInRupees");

        final response =
            await createRazorpayOrder(amountInRupees: amountInRupees);
        final orderId = response.id;
        final amount = response.amount;
        print("order id: $orderId");
        print("amount: $amount");

        // Updating global state
        ref.read(orderIdProvider.notifier).state = orderId;
        ref.read(amountProvider.notifier).state = amount;

        // Navigate or perform further actions here, ensuring context is still mounted
        if (!context.mounted) {
          return;
        }
        context.push("/razor_pay");
        // Navigate to the payment screen or show a confirmation
      } on TurfTouchException catch (_) {
        // Ensure the widget is still in the tree before trying to show a snackbar
        if (!context.mounted) {
          return;
        }
        getSnackBar(context: context, message: "Couldn't process the payment.");
      }
    } else {
      // TODO - call offline orders API
      // Handle the offline scenario or other payment methods
    }
  }

  @override
  void initState() {
    super.initState();
    getPackages();
    totalPrice = 0.0; // Initialize total price
  }

  void calculateTotalPrice(List<String> slots, List<Data>? pricingData) {
    totalPrice = 0.0; // Reset total price
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

    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    String formattedDate = DateFormat('d MMMM y').format(selectedDate!);
    final slots = ref.watch(selectedTimeSlotsProvider);
    String formattedSlots = formatSelectedSlots(slots);
    // Recalculate the total price every time the slots change
    calculateTotalPrice(slots, prices.data);

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "One Last Step. Please Choose a payment method to continue.",
            style: CTheme.of(context).theme.bodyText,
          ),
          const Gap(30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            alignment: Alignment.center,
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    fit: BoxFit.cover, image: AssetImage("assets/turf/1.jpg"))),
          ),
          const Gap(30),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: CTheme.of(context)
                          .theme
                          .backgroundInverse
                          .withOpacity(0.2),
                      offset: Offset.fromDirection(360),
                      spreadRadius: 2,
                      blurRadius: 4),
                ],
                color: CTheme.of(context).theme.backgroundColor),
            width: double.infinity,
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedDate,
                          style: CTheme.of(context).theme.label,
                        ),
                        Text(
                          "Slots: $formattedSlots",
                          style: CTheme.of(context).theme.bodyText,
                        ),
                      ],
                    )),
                const Gap(20),
                Expanded(
                  flex: 1,
                  child: Text(
                    " ₹${totalPrice.toStringAsFixed(2)}",
                    style: CTheme.of(context).theme.subheading.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              ],
            ),
          ),
          const Gap(20),
          Container(
            decoration: BoxDecoration(
              color: CTheme.of(context).theme.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: CTheme.of(context)
                        .theme
                        .backgroundInverse
                        .withOpacity(0.2),
                    offset: Offset.fromDirection(360),
                    spreadRadius: 2,
                    blurRadius: 4),
              ],
            ),
            child: CheckboxListTile(
              title:
                  Text("Pay on Spot", style: CTheme.of(context).theme.bodyText),
              value: payOnSpot,
              onChanged: (bool? value) {
                setState(() {
                  payOnSpot = value!;
                  razorPay =
                      !payOnSpot; // Uncheck Razor Pay if Pay on Spot is checked
                });
              },
              secondary: Icon(
                Icons.payment,
                color: CTheme.of(context).theme.backgroundInverse,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Gap(20),
          Container(
            decoration: BoxDecoration(
              color: CTheme.of(context).theme.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: CTheme.of(context)
                        .theme
                        .backgroundInverse
                        .withOpacity(0.2),
                    offset: Offset.fromDirection(360),
                    spreadRadius: 2,
                    blurRadius: 4),
              ],
            ),
            child: CheckboxListTile(
              title: Text(
                "Razor Pay",
                style: CTheme.of(context).theme.bodyText,
              ),
              value: razorPay,
              onChanged: (bool? value) {
                setState(() {
                  razorPay = value!;
                  payOnSpot =
                      !razorPay; // Uncheck Pay on Spot if Razor Pay is checked
                });
              },
              secondary: Icon(
                Icons.credit_card,
                color: CTheme.of(context).theme.backgroundInverse,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Gap(20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: onPaymentPress,
              style: CTheme.of(context).theme.buttonStyle,
              child: const Text("Pay"),
            ),
          )
        ],
      ),
    );
  }
}
