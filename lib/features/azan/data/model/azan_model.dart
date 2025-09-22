import 'package:intl/intl.dart';

import 'AzanModel2.dart';

class PrayerTimeModel {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerTimeModel({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimeModel(
      fajr: json['Fajr'] ?? '',
      dhuhr: json['Dhuhr'] ?? '',
      asr: json['Asr'] ?? '',
      maghrib: json['Maghrib'] ?? '',
      isha: json['Isha'] ?? '',
    );
  }

  List<AzanModel> toAzanList() {
    return [
      AzanModel(name: 'Fajr', time: _parseTime(fajr)),
      AzanModel(name: 'Dhuhr', time: _parseTime(dhuhr)),
      AzanModel(name: 'Asr', time: _parseTime(asr)),
      AzanModel(name: 'Maghrib', time: _parseTime(maghrib)),
      AzanModel(name: 'Isha', time: _parseTime(isha)),
    ];
  }

  DateTime _parseTime(String raw) {
    try {
      final now = DateTime.now();
      final parsed = DateFormat("HH:mm").parse(raw);
      return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
    } catch (_) {
      return DateTime.now();
    }
  }
}
