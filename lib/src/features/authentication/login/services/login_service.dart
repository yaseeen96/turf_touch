import 'package:dio/dio.dart';
import 'package:turf_touch/src/config/dio/dio_config.dart';
import 'package:turf_touch/src/features/authentication/login/models/login_response_model.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';

Future<LoginResponseModel> loginService(String email, String password) async {
  try {
    final response = await dioClient.post("/login", data: {
      "email": email,
      "password": password,
    });

    final jsonResponse = LoginResponseModel.fromJson(response.data);
    return jsonResponse;
  } on DioException catch (err) {
    throw TurfTouchException(
        err.response?.data?["message"] ?? "Unknown Error Occurred");
  }
}
