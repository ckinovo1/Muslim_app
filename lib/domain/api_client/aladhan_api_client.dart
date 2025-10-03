import 'package:dio/dio.dart';
import 'package:muslim_app/domain/entity/prayer_api.dart';

class AladhanApiClient {
  static const String baseUrl = 'https://api.aladhan.com/v1/';

  static Dio createDieInstance() {
    return Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<PrayerApi?> getPrayerTimes(double lat, double lng) async {
    Dio dio = createDieInstance();
    try {
      Response res = await dio.get(
        'timingsByCoords',
        queryParameters: {'latitude': lat, 'longitude': lng, 'method': 2},
      );

      if(res.statusCode == 200){
        return PrayerApi.fromJson(res.data);
      }else {
        throw Exception('Error fetching prayer times');
      }
    } on DioException catch (e) {
      print(e.message);
      return null;
    }
  }
}
