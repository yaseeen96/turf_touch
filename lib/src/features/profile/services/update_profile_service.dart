import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:dio/dio.dart';
import 'package:turf_touch/src/config/dio/dio_config.dart';
import 'package:turf_touch/src/shared/exceptions/exceptions.dart';
import 'dart:math';
import 'dart:convert';

import 'package:turf_touch/src/shared/helpers/convert_to_12.dart';

String generateRandomName() {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final random = Random.secure();
  // Create a random byte array.
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  // Convert bytes to a hex string.
  final uuid = base64Url.encode(bytes);
  // Combine timestamp and random hex string.
  return 'Name_${timestamp}_$uuid';
}

Future<bool> updateProfileService({
  File? file,
  String? password,
  required String firstName,
  required String lastName,
  required String mobileNumber,
}) async {
  try {
    const store = storage.FlutterSecureStorage();
    final token = await store.read(key: "token");
    FormData formData = FormData.fromMap({
      'pwd': password,
      'first_name': firstName,
      'last_name': lastName,
      'phone_no': mobileNumber,
      if (file != null)
        'profile': await MultipartFile.fromFile(file.path,
            filename: generateRandomName()),
    });
    final response = await dioClient.post("/update_profile/2",
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}));
    if (response.statusCode == HttpStatus.created) {
      return true;
    }
    return true;
  } on DioException catch (err) {
    logger.e(err.response!.data.toString());
    throw TurfTouchException("Can't Update Data");
  }
}
