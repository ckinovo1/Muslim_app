import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:muslim_app/domain/entity/prayer_api.dart';
import 'package:muslim_app/data/services/geolocator_service.dart';

class PrayerTimesExtended {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String duha;
  final String tahajjud;

  PrayerTimesExtended({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.duha,
    required this.tahajjud,
  });
}

class PrayerTimeService {
  final GeolocatorService geoService;
  final Dio dio;

  PrayerTimeService({required this.geoService})
      : dio = Dio(BaseOptions(baseUrl: 'https://api.aladhan.com/v1/'));

  /// Получаем основные намазы + вычисляем Duha и Tahajjud
  Future<PrayerTimesExtended?> getPrayerTimes() async {
    final position = await geoService.getCurrentLocation();
    if (position == null) return null;

    final latitude = position.latitude;
    final longitude = position.longitude;

    try {
      final response = await dio.get(
        '/timings',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'method': 2,
        },
      );

      if (response.statusCode == 200 && response.data['code'] == 200) {
        final prayerApi = await compute<Map<String, dynamic>, PrayerApi>(
          (data) => PrayerApi.fromJson(data),
          Map<String, dynamic>.from(response.data),
        );

        final fajr = prayerApi.data.timings.fajr;
        final sunrise = prayerApi.data.timings.sunrise;
        final dhuhr = prayerApi.data.timings.dhuhr;
        final asr = prayerApi.data.timings.asr;
        final maghrib = prayerApi.data.timings.maghrib;
        final isha = prayerApi.data.timings.isha;

        final duhaTime = _calculateDuha(sunrise);
        final tahajjudTime = _calculateTahajjud(maghrib, fajr);

        return PrayerTimesExtended(
          fajr: fajr,
          sunrise: sunrise,
          dhuhr: dhuhr,
          asr: asr,
          maghrib: maghrib,
          isha: isha,
          duha: duhaTime,
          tahajjud: tahajjudTime,
        );
      }

      return null;
    } catch (e) {
      debugPrint('Error fetching prayer times: $e');
      return null;
    }
  }

  String _calculateDuha(String sunrise) {
    final parts = sunrise.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    minute += 20;
    if (minute >= 60) {
      hour += 1;
      minute -= 60;
    }
    return '${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2,'0')}';
  }

  String _calculateTahajjud(String maghrib, String fajr) {
    final maghribParts = maghrib.split(':');
    final fajrParts = fajr.split(':');

    final maghribMinutes = int.parse(maghribParts[0]) * 60 + int.parse(maghribParts[1]);
    final fajrMinutes = int.parse(fajrParts[0]) * 60 + int.parse(fajrParts[1]);

    int nightDuration = (24 * 60 - maghribMinutes + fajrMinutes) % (24 * 60);
    int tahajjudMinutes = (maghribMinutes + nightDuration ~/ 2) % (24 * 60);

    final hour = tahajjudMinutes ~/ 60;
    final minute = tahajjudMinutes % 60;

    return '${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2,'0')}';
  }
}
