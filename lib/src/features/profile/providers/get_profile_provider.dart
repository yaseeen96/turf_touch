import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turf_touch/src/features/profile/models/my_profile_response_model.dart';
import 'package:turf_touch/src/features/profile/services/get_profile_service.dart';

final getProfileProvider = FutureProvider<MyProfileResponseModel>((ref) async {
  final response = await getProfileService();
  return response;
});
