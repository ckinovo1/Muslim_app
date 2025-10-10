import 'package:flutter/material.dart';
import 'package:muslim_app/data/services/geolocator_service.dart';
import 'package:muslim_app/data/services/prayer_time_service.dart';
import 'package:muslim_app/data/services/notification_service.dart';
import 'package:muslim_app/factories/screen_factory.dart';
import 'package:muslim_app/ui/navigation/app_router.dart';
import 'package:muslim_app/ui/widgets/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Сервисы
  final geoService = GeolocatorService();
  final prayerService = PrayerTimeService(geoService: geoService);
  final notificationService = NotificationService(geoService);

  // Фабрика экранов
  final screenFactory = ScreenFactory(
    geoService: geoService,
    prayerService: prayerService,
    notificationService: notificationService,
  );

  // Роутер
  final appRouter = AppRouter(screenFactory: screenFactory);

  runApp(MyApp(appRouter: appRouter));
}
