// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'prayer_api.g.dart';

@JsonSerializable()
class PrayerApi {
  final int code;
  final String status;
  final PrayerData data;

  PrayerApi({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PrayerApi.fromJson(Map<String, dynamic> json) =>
      _$PrayerApiFromJson(json);
  Map<String, dynamic> toJson() => _$PrayerApiToJson(this);
}

@JsonSerializable()
class PrayerData {
  final DataTimings timings;
  final PrayerDate date;
  final PrayerMeta meta;

  PrayerData({
    required this.timings,
    required this.date,
    required this.meta,
  });

  factory PrayerData.fromJson(Map<String, dynamic> json) =>
      _$PrayerDataFromJson(json);
  Map<String, dynamic> toJson() => _$PrayerDataToJson(this);
}

@JsonSerializable()
class DataTimings {
  @JsonKey(name: "Fajr")
  final String fajr;

  @JsonKey(name: "Sunrise")
  final String sunrise;

  @JsonKey(name: "Dhuhr")
  final String dhuhr;

  @JsonKey(name: "Asr")
  final String asr;

  @JsonKey(name: "Sunset")
  final String sunset;

  @JsonKey(name: "Maghrib")
  final String maghrib;

  @JsonKey(name: "Isha")
  final String isha;

  @JsonKey(name: "Imsak")
  final String imsak;

  @JsonKey(name: "Midnight")
  final String midnight;

  DataTimings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
  });

  factory DataTimings.fromJson(Map<String, dynamic> json) =>
      _$DataTimingsFromJson(json);
  Map<String, dynamic> toJson() => _$DataTimingsToJson(this);
}

@JsonSerializable()
class PrayerDate {
  final String readable;
  final String timestamp;
  final GregorianDate gregorian;
  final HijriDate hijri;

  PrayerDate({
    required this.readable,
    required this.timestamp,
    required this.gregorian,
    required this.hijri,
  });

  factory PrayerDate.fromJson(Map<String, dynamic> json) =>
      _$PrayerDateFromJson(json);
  Map<String, dynamic> toJson() => _$PrayerDateToJson(this);
}

@JsonSerializable()
class GregorianDate {
  final String date;
  final GregorianMonth month;
  final String year;
  final GregorianWeekday weekday;

  GregorianDate({
    required this.date,
    required this.month,
    required this.year,
    required this.weekday,
  });

  factory GregorianDate.fromJson(Map<String, dynamic> json) =>
      _$GregorianDateFromJson(json);
  Map<String, dynamic> toJson() => _$GregorianDateToJson(this);
}

@JsonSerializable()
class GregorianMonth {
  final int number;
  final String en;

  GregorianMonth({required this.number, required this.en});

  factory GregorianMonth.fromJson(Map<String, dynamic> json) =>
      _$GregorianMonthFromJson(json);
  Map<String, dynamic> toJson() => _$GregorianMonthToJson(this);
}

@JsonSerializable()
class GregorianWeekday {
  final String en;

  GregorianWeekday({required this.en});

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) =>
      _$GregorianWeekdayFromJson(json);
  Map<String, dynamic> toJson() => _$GregorianWeekdayToJson(this);
}

@JsonSerializable()
class HijriDate {
  final String date;
  final HijriMonth month;
  final String year;
  final HijriWeekday weekday;

  HijriDate({
    required this.date,
    required this.month,
    required this.year,
    required this.weekday,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) =>
      _$HijriDateFromJson(json);
  Map<String, dynamic> toJson() => _$HijriDateToJson(this);
}

@JsonSerializable()
class HijriMonth {
  final int number;
  final String en;
  final String ar;

  HijriMonth({required this.number, required this.en, required this.ar});

  factory HijriMonth.fromJson(Map<String, dynamic> json) =>
      _$HijriMonthFromJson(json);
  Map<String, dynamic> toJson() => _$HijriMonthToJson(this);
}

@JsonSerializable()
class HijriWeekday {
  final String en;
  final String ar;

  HijriWeekday({required this.en, required this.ar});

  factory HijriWeekday.fromJson(Map<String, dynamic> json) =>
      _$HijriWeekdayFromJson(json);
  Map<String, dynamic> toJson() => _$HijriWeekdayToJson(this);
}

@JsonSerializable()
class PrayerMeta {
  final double latitude;
  final double longitude;
  final String timezone;
  final MetaMethod method;

  PrayerMeta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
  });

  factory PrayerMeta.fromJson(Map<String, dynamic> json) =>
      _$PrayerMetaFromJson(json);
  Map<String, dynamic> toJson() => _$PrayerMetaToJson(this);
}

@JsonSerializable()
class MetaMethod {
  final int id;
  final String name;
  final MethodParams params;
  final MethodLocation location;

  MetaMethod({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory MetaMethod.fromJson(Map<String, dynamic> json) =>
      _$MetaMethodFromJson(json);
  Map<String, dynamic> toJson() => _$MetaMethodToJson(this);
}

@JsonSerializable()
class MethodParams {
  final int Fajr;
  final int Isha;

  MethodParams({
    required this.Fajr,
    required this.Isha,
  });

  factory MethodParams.fromJson(Map<String, dynamic> json) =>
      _$MethodParamsFromJson(json);
  Map<String, dynamic> toJson() => _$MethodParamsToJson(this);
}

@JsonSerializable()
class MethodLocation {
  final double latitude;
  final double longitude;

  MethodLocation({
    required this.latitude,
    required this.longitude,
  });

  factory MethodLocation.fromJson(Map<String, dynamic> json) =>
      _$MethodLocationFromJson(json);
  Map<String, dynamic> toJson() => _$MethodLocationToJson(this);
}
