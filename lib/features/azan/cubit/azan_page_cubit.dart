import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import '../data/model/AzanModel2.dart';
import '../data/model/azan_notifier.dart';
import '../data/prayer_repository.dart';
part 'azan_page_state.dart';

class AzanPageCubit extends Cubit<AzanPageState> {
  final PrayerRepository repository;

  AzanPageCubit(this.repository) : super(AzanPageInitial());

  Future<void> loadPrayerTimes() async {
    emit(AzanPageLoading());
    try {
      final (prayerTime, city, country) = await repository.fetchPrayerTimes();
      final prayers = prayerTime.toAzanList();

      final now = DateTime.now();
      final nextPrayer = prayers.firstWhere(
            (p) => p.time.isAfter(now),
        orElse: () => prayers.first,
      );

      // جدولة الأذان
      _scheduleAzan(nextPrayer);

      emit(AzanPageLoaded(
        prayerTimes: prayers,
        nextPrayer: nextPrayer,
        city: city,
        country: country,
      ));
    } catch (e) {
      emit(AzanPageError(e.toString()));
    }
  }

  void _scheduleAzan(AzanModel prayer) {
    final id = prayer.time.millisecondsSinceEpoch.remainder(100000);

    AndroidAlarmManager.oneShotAt(
      prayer.time,
      id,
      _azanCallback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
      params: {"prayerName": prayer.name},
    );
  }

  // الكولباك اللي بينادي الإشعار + الأذان
  static Future<void> _azanCallback(int id, Map<String, dynamic> params) async {
    final prayerName = params["prayerName"] ?? "الصلاة";
    await AzanNotifier.showAzanNotification(prayerName);
  }
}
