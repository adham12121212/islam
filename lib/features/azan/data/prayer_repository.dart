

import 'package:geocoding/geocoding.dart';
import 'package:islam/features/azan/data/services/location_service.dart';
import 'package:islam/features/azan/data/services/prayer_api_service.dart';

import 'model/azan_model.dart';

class PrayerRepository {
  final LocationService locationService;
  final PrayerApiService prayerApiService;

  PrayerRepository({
    required this.locationService,
    required this.prayerApiService,
  });

  Future<(PrayerTimeModel, String, String)> fetchPrayerTimes() async {
    final position = await locationService.getCurrentLocation();
    final timings = await prayerApiService.getPrayerTimes(
      position.latitude,
      position.longitude,
    );
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final city = placemarks.first.locality ?? "Unknown City";
    final country = placemarks.first.country ?? "Unknown Country";

    return (PrayerTimeModel.fromJson(timings), city, country);

  }
}

