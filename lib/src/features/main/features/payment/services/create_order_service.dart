import 'dart:convert';
import 'package:dio/dio.dart';

import 'dart:math';

import 'package:turf_touch/src/features/main/features/payment/models/razor_pay_create_order_response.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';

Future<RazorPayCreateOrderResponse> createRazorpayOrder(
    {required int amountInRupees}) async {
  const keyId = "rzp_test_AzCeskfoKUDV9H";
  const keySecret = "cRWLE7CLQZdx8nRQWILYyvd4";

  // Basic authentication encoding
  final auth = 'Basic ' + base64Encode(utf8.encode('$keyId:$keySecret'));
  // Convert amount from rupees to paise
  final int amountInPaise = (amountInRupees * 100).round();

  // Generate a random receipt string
  final random = Random();
  final receipt = 'rcptid_${random.nextInt(100000)}';

  final Dio dioClient = Dio();

  try {
    final response = await dioClient.post(
      'https://api.razorpay.com/v1/orders',
      data: {
        'amount': amountInPaise,
        'currency': 'INR',
        'receipt': receipt,
        'partial_payment': false,
      },
      options: Options(
        headers: {
          'Authorization': auth,
          'Content-Type': 'application/json',
        },
      ),
    );
    return RazorPayCreateOrderResponse.fromJson(
        response.data); // Assuming you will handle the response outside
  } on DioException catch (e) {
    throw TurfTouchException("Failed to create Razorpay order: ${e.message}");
  }
}
