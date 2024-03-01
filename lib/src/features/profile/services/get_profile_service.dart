import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:turf_touch/src/config/dio/dio_config.dart';
import 'package:turf_touch/src/features/profile/models/my_profile_response_model.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';

Future<MyProfileResponseModel> getProfileService() async {
  try {
    const store = storage.FlutterSecureStorage();
    final token = await store.read(key: "token");
    final response = await dioClient.get("/get_profile/2",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    final jsonResponse = MyProfileResponseModel.fromJson(response.data);
    return jsonResponse;
  } on DioException {
    throw TurfTouchException("Can't Get Profile");
  }
}
