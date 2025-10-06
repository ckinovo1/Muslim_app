import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:muslim_app/domain/entity/prayer_api.dart';
import 'package:muslim_app/services/geolocator_service.dart';

class PrayerTimeService {
  final GeolocatorService geoService;
  final Dio dio;

  PrayerTimeService({required this.geoService})
      : dio = Dio(BaseOptions(baseUrl: 'https://api.aladhan.com/v1/'));

  /// Получает время намазов для текущей геолокации
  Future<PrayerApi?> getPrayerTimes() async {
    final position = await geoService.getCurrentLocation();
    if (position == null) return null;

    final latitude = position.latitude;
    final longitude = position.longitude;

    final url = '/timings?latitude=$latitude&longitude=$longitude&method=2';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 && response.data['code'] == 200) {
        // compute для парсинга в отдельном изоляте
        return await compute<Map<String, dynamic>, PrayerApi>(
          (data) => PrayerApi.fromJson(data),
          Map<String, dynamic>.from(response.data),
        );
      } else {
        throw Exception(
          'API error: ${response.statusCode}, ${response.data["message"] ?? ""}',
        );
      }
    } on DioException catch (e) {
      debugPrint('HTTP Error: ${e.message}, Status Code: ${e.response?.statusCode}');
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }

  /// Рассчитывает время Духа (примерно 20 минут после восхода)
  TimeOfDay calculateDuha(String sunrise) {
    final parts = sunrise.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    minute += 20;
    if (minute >= 60) {
      hour += 1;
      minute -= 60;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Рассчитывает время Тахаджуд (середина ночи между Магриб и Фаджр)
  TimeOfDay calculateTahajjud(String maghrib, String fajr) {
    final maghribParts = maghrib.split(':');
    final fajrParts = fajr.split(':');

    final maghribMinutes = int.parse(maghribParts[0]) * 60 + int.parse(maghribParts[1]);
    final fajrMinutes = int.parse(fajrParts[0]) * 60 + int.parse(fajrParts[1]);

    int nightDuration = (24 * 60 - maghribMinutes + fajrMinutes) % (24 * 60);
    int tahajjudMinutes = (maghribMinutes + nightDuration ~/ 2) % (24 * 60);

    return TimeOfDay(hour: tahajjudMinutes ~/ 60, minute: tahajjudMinutes % 60);
  }
}
