import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';
import 'package:turf_touch/src/features/main/features/payment/providers/payment_providers.dart';

class RazorPayScreen extends ConsumerStatefulWidget {
  const RazorPayScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends ConsumerState<RazorPayScreen> {
  @override
  void initState() {
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startPayment();
    });
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // TODO - call orders API over here
    context.go("/history");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("error from handlepayment error: ${response.message}");
    context.go("/order_failure");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  void _startPayment() {
    // Here we build the options dynamically using state from Riverpod
    final orderId =
        ref.read(orderIdProvider); // Assuming you have these providers
    final amount = ref.read(amountProvider) ?? 50000; // Default value

    var options = {
      'key': 'rzp_test_AzCeskfoKUDV9H',
      'amount': amount, // Use the amount from state
      'name': 'TurfTouch',
      'order_id': orderId, // Use the order ID from state
      'description': 'Turf Ground',
      'timeout': 60, // in seconds
      'prefill': {'contact': '9000090000', 'email': 'gaurav.kumar@example.com'}
    };

    _razorPay.open(options);
  }

  @override
  void dispose() {
    _razorPay.clear();
    super.dispose();
  }

  final _razorPay = Razorpay();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CTheme.of(context).theme.backgroundColor,
    );
  }
}
