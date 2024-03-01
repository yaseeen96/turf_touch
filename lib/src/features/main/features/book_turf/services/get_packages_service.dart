import 'package:dio/dio.dart';
import 'package:turf_touch/src/config/dio/dio_config.dart';
import 'package:turf_touch/src/features/main/features/book_turf/models/get_packages_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';

Future<GetPackagesResponseModel> getPackagesService() async {
  try {
    const store = storage.FlutterSecureStorage();
    final token = await store.read(key: "token");
    final response = await dioClient.get("/package",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    final jsonResponse = GetPackagesResponseModel.fromJson(response.data);
    return jsonResponse;
  } on DioException catch (_) {
    throw TurfTouchException("Unable to fetch packages");
  }
}
