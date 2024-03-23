import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:turf_touch/src/config/dio/dio_config.dart';
import 'package:turf_touch/src/constants/endpoints.dart';
import 'package:turf_touch/src/features/main/models/home_screen_data_model.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';

final homeScreenProvider = FutureProvider<HomeScreenDataModel>(
  (ref) async {
    try {
      const store = storage.FlutterSecureStorage();
      final token = await store.read(key: "token");
      final response = await dioClient.get(
        EndPoints.getHomeScreenData,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
        return HomeScreenDataModel.fromJson(response.data);
      } else {
        throw TurfTouchException("Uh Oh! Something went wrong");
      }
    } on DioException catch (err, _) {
      throw TurfTouchException(
          "Uh Oh! Something went wrong. Please try again later.");
    }
  },
);
