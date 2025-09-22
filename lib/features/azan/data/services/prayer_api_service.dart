import 'package:dio/dio.dart';

import 'location_service.dart';

class PrayerApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getPrayerTimes(double lat, double lng) async {
    const url = "http://api.aladhan.com/v1/timings?latitude=..&longitude=..&method=5";
    final response = await _dio.get(url, queryParameters: {
      "latitude": lat,
      "longitude": lng,
      "method": 5,
    });

    if (response.statusCode == 200) {
      return response.data['data']['timings'];
    } else {
      throw Exception("فشل في جلب مواعيد الصلاة");
    }
  }
}

