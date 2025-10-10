import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/data/services/geolocator_service.dart';
import 'package:muslim_app/data/services/prayer_time_service.dart';
import 'package:muslim_app/data/services/notification_service.dart';
import 'package:muslim_app/bloc/prayer/prayer_bloc.dart';
import 'package:muslim_app/ui/widgets/prayer/prayer_screen.dart';
import 'package:muslim_app/ui/widgets/service/service_screen.dart';
import 'package:muslim_app/ui/widgets/settings_screen.dart/settings_screen.dart';

class ScreenFactory {
  final GeolocatorService geoService;
  final PrayerTimeService prayerService;
  final NotificationService notificationService;

  ScreenFactory({
    required this.geoService,
    required this.prayerService,
    required this.notificationService,
  });

  Widget makePrayerScreen() {
    return FutureBuilder(
      future: notificationService.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
          );
        }

        return BlocProvider(
          create: (_) => PrayerBloc(
            prayerService: prayerService,
            notificationService: notificationService,
          )..add(LoadPrayerTimes()),
          child: const PrayerScreen(),
        );
      },
    );
  }

  Widget makeServiceScreen() => const ServiceScreen();
  Widget makeSettingsScreen() => const SettingsScreen();

  Widget makeDummyScreen(String title) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "Экран: $title",
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
