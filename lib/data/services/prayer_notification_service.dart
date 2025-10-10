// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class PrayerNotificationService {
// Future<void> schedulePrayerNotifications(List<Map<String, String>> prayers) async {
//   const androidDetails = AndroidNotificationDetails(
//     'prayer_channel',
//     'Намазы',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//   const notificationDetails = NotificationDetails(android: androidDetails);
//   final now = DateTime.now();

//   for (final prayer in prayers) {
//     final parts = prayer['time']!.split(':');
//     final scheduledTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       int.parse(parts[0]),
//       int.parse(parts[1]),
//     );

//     if (scheduledTime.isAfter(now)) {
//       await _localNotifications.zonedSchedule(
//         prayer['name']!.hashCode,
//         '🕌 ${prayer['name']} Намаз',
//         'Наступило время ${prayer['name']} намаза',
//         scheduledTime.toLocal(),
//         notificationDetails,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//       );
//     }
//   }
// }

// }