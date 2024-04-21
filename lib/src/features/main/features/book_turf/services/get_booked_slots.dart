import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:turf_touch/src/config/dio/dio_config.dart';
import 'package:turf_touch/src/features/main/features/book_turf/models/get_booked_slots_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';
import 'package:turf_touch/src/shared/helpers/convert_to_12.dart';

Future<GetBookedSlotsResponse> getBookedSlotsService(
    {required DateTime date}) async {
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  logger.i("formatted date: $formattedDate");
  try {
    const store = storage.FlutterSecureStorage();
    final token = await store.read(key: "token");
    final response = await dioClient.get(
        "/get_booked_slots_by_date/$formattedDate",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    final jsonResponse = GetBookedSlotsResponse.fromJson(response.data);
    return jsonResponse;
  } on DioException catch (err) {
    logger.e("error from get booked slots service", error: err);
    throw TurfTouchException("Can't get booked slots");
  }
}
