import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/services/geolocator_service.dart';
import 'package:muslim_app/services/prayer_time_service.dart';
import 'package:muslim_app/bloc/prayer/prayer_bloc.dart';
import 'package:muslim_app/ui/widgets/prayer/prayer_screen.dart';
import 'package:muslim_app/ui/widgets/service/service_screen.dart';
import 'package:muslim_app/ui/widgets/settings_screen.dart/settings_screen.dart';

class ScreenFactory {
  final GeolocatorService _geoService = GeolocatorService();
  Widget makePrayerScreen() {
    final service = PrayerTimeService(geoService: _geoService);
    return BlocProvider(
      create: (_) => PrayerBloc(service)..add(LoadPrayerTimes()),
      child: const PrayerScreen(),
    );
  }

  Widget makeServiceScreen() => const ServiceScreen();
  Widget makeSettingsScreen() => const SettingsScreen();

  Widget makeDummyScreen(String title) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text("Экран: $title", style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
