import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ✅ تأكد أن خدمة الموقع شغالة
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('⚠️ خدمة الموقع غير مفعلة');
    }

    // ✅ تحقق من الصلاحيات
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('⚠️ تم رفض صلاحية الموقع');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ✅ افتح إعدادات التطبيق للمستخدم
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      throw Exception('⚠️ الصلاحية مرفوضة دائماً، افتح الإعدادات لتفعيلها.');
    }

    // ✅ رجع الموقع الحالي
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
