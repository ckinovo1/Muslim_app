import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_app/data/services/geolocator_service.dart';
import 'package:muslim_app/data/services/prayer_time_service.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();

  final GeolocatorService geoService;

  static const String _channelId = 'prayer_channel';
  static const String _timeZoneApiKey = 'BJX4W145QX3Z'; // твой API ключ

  NotificationService(this.geoService);

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _flutterLocalNotifications.initialize(initSettings);

    const androidChannel = AndroidNotificationChannel(
      _channelId,
      'Prayer Notifications',
      description: 'Уведомления о времени намаза',
      importance: Importance.high,
    );

    await _flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    tzdata.initializeTimeZones();

    try {
      final position = await geoService.getCurrentLocation();
      print(position);
      if (position == null) {
        tz.setLocalLocation(tz.getLocation('Europe/Moscow'));
        log('⚠️ Локация недоступна, используется Europe/Moscow');
        return;
      }

      final timeZoneName = await _getTimeZoneFromAPI(
        position.latitude,
        position.longitude,
      );

      tz.setLocalLocation(tz.getLocation(timeZoneName));
      log('✅ Таймзона установлена: $timeZoneName');
    } catch (e) {
      log('❌ Ошибка инициализации таймзоны: $e');
      tz.setLocalLocation(tz.getLocation('Europe/Moscow'));
    }
  }

  Future<String> _getTimeZoneFromAPI(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.timezonedb.com/v2.1/get-time-zone?key=$_timeZoneApiKey&format=json&by=position&lat=$lat&lng=$lon');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['zoneName'] ?? 'Europe/Moscow';
    } else {
      throw Exception('Ошибка получения таймзоны: ${response.statusCode}');
    }
  }

  Future<void> schedulePrayerNotifications(PrayerTimesExtended prayers) async {
    final now = tz.TZDateTime.now(tz.local);

    final prayerMap = {
      'Фаджр': prayers.fajr,
      'Восход': prayers.sunrise,
       'Духа': prayers.duha,
      'Зухр': prayers.dhuhr,
      'Аср': prayers.asr,
      'Магриб': prayers.maghrib,
      'Иша': prayers.isha,
      'Тахаджуд': prayers.tahajjud,
    };

    for (final entry in prayerMap.entries) {
      final name = entry.key;
      final parts = entry.value.split(':');
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;

      tz.TZDateTime scheduled =
          tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

      if (scheduled.isBefore(now)) {
        scheduled = scheduled.add(const Duration(days: 1));
      }

      final details = NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'Намазы',
          channelDescription: 'Уведомления о времени намаза',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _flutterLocalNotifications.zonedSchedule(
        name.hashCode,
        '🕌 Время намаза: $name',
        'Наступило время $name',
        scheduled,
        details,
        androidScheduleMode: AndroidScheduleMode.inexact,//.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      log('🔔 Scheduled $name at $scheduled');
    }
  }
}
