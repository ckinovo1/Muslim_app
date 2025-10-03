import 'package:geolocator/geolocator.dart';

enum GeoStatus { enabled, disabled, denied, deniedForever, unknown }

class LocationServiceDisabledException implements Exception{
  final String message;

  LocationServiceDisabledException([this.message = 'Location service disabled']);
  @override
  String toString() => message; 
}

class LocationPermissionDeniedException implements Exception{
  final String message;
  LocationPermissionDeniedException([this.message = 'Location service denied']);

  @override
  String toString() => message;
}

class LocationPermissionDeniedForeverException implements Exception{
  final String message;
  LocationPermissionDeniedForeverException([this.message = 'Location service denied forever']);

  @override
  String toString() => message;
}




class GeolocatorService {
// ignore: body_might_complete_normally_nullable
Future<Position?> getCurrentPosition({
  LocationAccuracy accuracy = LocationAccuracy.high,int retries = 3,Duration timeout = const Duration(seconds: 10)
}) async {
  if (!await Geolocator.isLocationServiceEnabled()){
    throw LocationServiceDisabledException();
  }
}

  static const int maxRetryCount = 3; 

  Future<GeoStatus> checkGeoService() async {
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      return GeoStatus.disabled;
    }

    LocationPermission perm = await Geolocator.checkPermission();
    switch (perm) {
      case LocationPermission.denied:
        return GeoStatus.denied;
      case LocationPermission.deniedForever:
        return GeoStatus.deniedForever;
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return GeoStatus.enabled;
      default:
        return GeoStatus.unknown;
    }
  }

  /// Запрашивает разрешение на использование геолокации
  Future<GeoStatus> requestGeoPermission() async {
    LocationPermission perm = await Geolocator.requestPermission();
    switch (perm) {
      case LocationPermission.denied:
        return GeoStatus.denied;
      case LocationPermission.deniedForever:
        return GeoStatus.deniedForever;
      default:
        return GeoStatus.enabled;
    }
  }

  /// Получает текущее положение пользователя
  Future<Position?> getCurrentLocation({bool retryOnFailure = true}) async {
    GeoStatus status = await checkGeoService();
    if (status == GeoStatus.disabled || status == GeoStatus.deniedForever) {
      return null;
    }

    if (status == GeoStatus.denied) {
      status = await requestGeoPermission();
      if (status != GeoStatus.enabled) {
        return null;
      }
    }

    for (var i = 0; i <= maxRetryCount; i++) {
      try {
        Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        return pos;
      } catch (_) {}
    }

    return null;
  }
}