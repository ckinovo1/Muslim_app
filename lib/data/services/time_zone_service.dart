import 'dart:convert';
import 'package:http/http.dart' as http;

class TimeZoneService {
  static const String _apiKey = 'BJX4W145QX3Z';

  Future<String> getTimeZone(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://api.timezonedb.com/v2.1/get-time-zone?key=$_apiKey&format=json&by=position&lat=$latitude&lng=$longitude',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['zoneName'] ?? 'Europe/Moscow';
    } else {
      throw Exception('Ошибка при получении таймзоны: ${response.statusCode}');
    }
  }
}
