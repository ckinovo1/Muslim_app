import 'package:geolocator/geolocator.dart';

enum GeoStatus { enabled, disabled, denied, deniedForever, unknown }

class LocationServiceDisabledException implements Exception {
  final String message;
  LocationServiceDisabledException([this.message = 'Location service disabled']);
  @override
  String toString() => message;
}

class LocationPermissionDeniedException implements Exception {
  final String message;
  LocationPermissionDeniedException([this.message = 'Location service denied']);
  @override
  String toString() => message;
}

class LocationPermissionDeniedForeverException implements Exception {
  final String message;
  LocationPermissionDeniedForeverException([this.message = 'Location service denied forever']);
  @override
  String toString() => message;
}

class GeolocatorService {
  static const int maxRetryCount = 3;

  Future<GeoStatus> checkGeoService() async {
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return GeoStatus.disabled;

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

  Future<Position?> getCurrentLocation({bool retryOnFailure = true}) async {
    GeoStatus status = await checkGeoService();
    if (status == GeoStatus.disabled || status == GeoStatus.deniedForever) return null;

    if (status == GeoStatus.denied) {
      status = await requestGeoPermission();
      if (status != GeoStatus.enabled) return null;
    }

    for (var i = 0; i <= maxRetryCount; i++) {
      try {
        return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      } catch (_) {}
    }

    return null;
  }
}
