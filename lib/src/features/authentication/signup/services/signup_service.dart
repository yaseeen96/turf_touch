import 'dart:io';

import 'package:dio/dio.dart';
import 'package:turf_touch/src/config/dio/dio_config.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';

Future<String> signupService({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String mobileNumber,
}) async {
  try {
    final response = await dioClient.post("/register", data: {
      "first_name": firstName,
      "last_name": lastName,
      "phone_no": mobileNumber,
      "email": email,
      "password": password
    });

    final jsonResponse = response.data;
    if (response.statusCode == HttpStatus.created) {
      return jsonResponse["message"] ?? "User Registered";
    }
    return "Yayy. User Registered";
  } on DioException {
    throw TurfTouchException("Can't Register User");
  }
}
