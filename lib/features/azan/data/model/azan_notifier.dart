import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';

class AzanNotifier {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> showAzanNotification(String prayerName) async {
    const androidDetails = AndroidNotificationDetails(
      'azan_channel',
      'Azan Notifications',
      channelDescription: 'Prayer Time Alerts',
      importance: Importance.max,
      priority: Priority.high,
      playSound: false, // الصوت هنديره بالأوديو بلاير
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      0,
      '📢 وقت الصلاة',
      'حان الآن وقت $prayerName',
      details,
    );

    // تشغيل صوت الأذان
    await _player.play(AssetSource('sounds/azan.mp3'));
  }
}
