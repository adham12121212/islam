import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'features/azan/cubit/azan_page_cubit.dart';
import 'features/azan/data/prayer_repository.dart';
import 'features/azan/data/services/location_service.dart';
import 'features/azan/data/services/prayer_api_service.dart';
import 'features/home/view/home_page.dart';
import 'features/splash/splash_page.dart';
import 'features/tsbih/cubit/tasbih_cubit.dart';

// 🔔 Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// 📢 الدالة اللي هتشتغل في الخلفية
void showAzanNotification() async {
  const androidDetails = AndroidNotificationDetails(
    'azan_channel',
    'Azan Notifications',
    channelDescription: 'إشعارات الأذان',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );
  const details = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    "📢 وقت الصلاة",
    "حان الآن موعد الأذان",
    details,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ تهيئة Alarm Manager
  await AndroidAlarmManager.initialize();

  // ✅ تهيئة Notifications
  const AndroidInitializationSettings initSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
  InitializationSettings(android: initSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  // 🔹 اختبار تحديد الموقع
  try {
    Position position = await LocationService().getCurrentLocation();
    print("📍 موقعي الحالي: ${position.latitude}, ${position.longitude}");
  } catch (e) {
    print("⚠️ خطأ في تحديد الموقع: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PrayerRepository(
      locationService: LocationService(),
      prayerApiService: PrayerApiService(),
    );

    return RepositoryProvider(
      create: (_) => repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AzanPageCubit(repository)..loadPrayerTimes(),
          ),
          BlocProvider(
            create: (_) => TasbihCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Islami",
          theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Tajawal',
          ),
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/home': (context) => const HomePage(),
          },
        ),
      ),
    );
  }
}
