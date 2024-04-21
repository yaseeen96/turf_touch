import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/main/features/book_turf/providers/book_turf_providers.dart';
import 'package:turf_touch/src/features/main/features/payment/providers/payment_providers.dart';
import 'package:turf_touch/src/features/main/features/payment/services/create_order_service.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';
import 'package:turf_touch/src/shared/helpers/convert_to_12.dart';
import 'package:turf_touch/src/shared/widgets/top_snackbar.dart';

class PaymentStepper extends ConsumerStatefulWidget {
  const PaymentStepper({
    super.key,
    required this.currentStep,
  });
  final int currentStep;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentStepperState();
}

class _PaymentStepperState extends ConsumerState<PaymentStepper> {
  bool payOnSpot = false;
  bool razorPay = false;

  String formatSelectedSlots(List<String> slots) {
    // Convert each slot to 12-hour format and join with a comma and a space
    return slots.map((slot) => convertTo12HourFormat(slot)).join(', ');
  }

  void onPaymentPress({required double totalPrice}) async {
    if (razorPay) {
      // Place order from API
      try {
        // Assuming totalPrice is a double, convert it to paise by multiplying by 100
        final int amountInRupees = totalPrice.toInt();
        logger.i("Amount in paise: $amountInRupees");

        final response =
            await createRazorpayOrder(amountInRupees: amountInRupees);
        final orderId = response.id;
        final amount = response.amount;
        logger.i("order id: $orderId");
        logger.i("amount: $amount");

        // Updating global state
        ref.read(orderIdProvider.notifier).state = orderId;
        ref.read(amountProvider.notifier).state = amount;

        // Navigate or perform further actions here, ensuring context is still mounted
        if (!mounted) {
          return;
        }
        context.push("/razor_pay");
        // Navigate to the payment screen or show a confirmation
      } on TurfTouchException catch (_) {
        // Ensure the widget is still in the tree before trying to show a snackbar
        if (!context.mounted) {
          return;
        }
        getSnackBar(
          context: context,
          message: "Couldn't process the payment.",
          type: SNACKBARTYPE.error,
        );
      }
    } else {
      // TODO - call offline orders API
      // Handle the offline scenario or other payment methods
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    String formattedDate = DateFormat('d MMMM y').format(selectedDate!);
    final slots = ref.watch(selectedTimeSlotsProvider);
    String formattedSlots = formatSelectedSlots(slots);
    final packages = ref.watch(getPackagesProvider);

    return packages.when(
      data: (data) {
        final double totalPrice = data;
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
                        fit: BoxFit.cover,
                        image: AssetImage("assets/turf/1.jpg"))),
              ),
              const Gap(30),
              Container(
                constraints: const BoxConstraints(minHeight: 200, maxHeight: 500),
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
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 5,
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
                        flex: 3,
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
                  activeColor: CTheme.of(context).theme.primaryColor,
                  title: Text("Pay on Spot",
                      style: CTheme.of(context).theme.bodyText),
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
                  onPressed: () {
                    onPaymentPress(totalPrice: totalPrice);
                  },
                  style: CTheme.of(context).theme.buttonStyle,
                  child: const Text("Pay"),
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Uh Ohh. something went wrong"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
