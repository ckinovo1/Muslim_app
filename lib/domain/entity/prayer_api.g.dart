// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrayerApi _$PrayerApiFromJson(Map<String, dynamic> json) => PrayerApi(
  code: (json['code'] as num).toInt(),
  status: json['status'] as String,
  data: PrayerData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PrayerApiToJson(PrayerApi instance) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'data': instance.data,
};

PrayerData _$PrayerDataFromJson(Map<String, dynamic> json) => PrayerData(
  timings: DataTimings.fromJson(json['timings'] as Map<String, dynamic>),
  date: PrayerDate.fromJson(json['date'] as Map<String, dynamic>),
  meta: PrayerMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PrayerDataToJson(PrayerData instance) =>
    <String, dynamic>{
      'timings': instance.timings,
      'date': instance.date,
      'meta': instance.meta,
    };

DataTimings _$DataTimingsFromJson(Map<String, dynamic> json) => DataTimings(
  fajr: json['Fajr'] as String,
  sunrise: json['Sunrise'] as String,
  dhuhr: json['Dhuhr'] as String,
  asr: json['Asr'] as String,
  sunset: json['Sunset'] as String,
  maghrib: json['Maghrib'] as String,
  isha: json['Isha'] as String,
  imsak: json['Imsak'] as String,
  midnight: json['Midnight'] as String,
);

Map<String, dynamic> _$DataTimingsToJson(DataTimings instance) =>
    <String, dynamic>{
      'Fajr': instance.fajr,
      'Sunrise': instance.sunrise,
      'Dhuhr': instance.dhuhr,
      'Asr': instance.asr,
      'Sunset': instance.sunset,
      'Maghrib': instance.maghrib,
      'Isha': instance.isha,
      'Imsak': instance.imsak,
      'Midnight': instance.midnight,
    };

PrayerDate _$PrayerDateFromJson(Map<String, dynamic> json) => PrayerDate(
  readable: json['readable'] as String,
  timestamp: json['timestamp'] as String,
  gregorian: GregorianDate.fromJson(json['gregorian'] as Map<String, dynamic>),
  hijri: HijriDate.fromJson(json['hijri'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PrayerDateToJson(PrayerDate instance) =>
    <String, dynamic>{
      'readable': instance.readable,
      'timestamp': instance.timestamp,
      'gregorian': instance.gregorian,
      'hijri': instance.hijri,
    };

GregorianDate _$GregorianDateFromJson(Map<String, dynamic> json) =>
    GregorianDate(
      date: json['date'] as String,
      month: GregorianMonth.fromJson(json['month'] as Map<String, dynamic>),
      year: json['year'] as String,
      weekday: GregorianWeekday.fromJson(
        json['weekday'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$GregorianDateToJson(GregorianDate instance) =>
    <String, dynamic>{
      'date': instance.date,
      'month': instance.month,
      'year': instance.year,
      'weekday': instance.weekday,
    };

GregorianMonth _$GregorianMonthFromJson(Map<String, dynamic> json) =>
    GregorianMonth(
      number: (json['number'] as num).toInt(),
      en: json['en'] as String,
    );

Map<String, dynamic> _$GregorianMonthToJson(GregorianMonth instance) =>
    <String, dynamic>{'number': instance.number, 'en': instance.en};

GregorianWeekday _$GregorianWeekdayFromJson(Map<String, dynamic> json) =>
    GregorianWeekday(en: json['en'] as String);

Map<String, dynamic> _$GregorianWeekdayToJson(GregorianWeekday instance) =>
    <String, dynamic>{'en': instance.en};

HijriDate _$HijriDateFromJson(Map<String, dynamic> json) => HijriDate(
  date: json['date'] as String,
  month: HijriMonth.fromJson(json['month'] as Map<String, dynamic>),
  year: json['year'] as String,
  weekday: HijriWeekday.fromJson(json['weekday'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HijriDateToJson(HijriDate instance) => <String, dynamic>{
  'date': instance.date,
  'month': instance.month,
  'year': instance.year,
  'weekday': instance.weekday,
};

HijriMonth _$HijriMonthFromJson(Map<String, dynamic> json) => HijriMonth(
  number: (json['number'] as num).toInt(),
  en: json['en'] as String,
  ar: json['ar'] as String,
);

Map<String, dynamic> _$HijriMonthToJson(HijriMonth instance) =>
    <String, dynamic>{
      'number': instance.number,
      'en': instance.en,
      'ar': instance.ar,
    };

HijriWeekday _$HijriWeekdayFromJson(Map<String, dynamic> json) =>
    HijriWeekday(en: json['en'] as String, ar: json['ar'] as String);

Map<String, dynamic> _$HijriWeekdayToJson(HijriWeekday instance) =>
    <String, dynamic>{'en': instance.en, 'ar': instance.ar};

PrayerMeta _$PrayerMetaFromJson(Map<String, dynamic> json) => PrayerMeta(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  timezone: json['timezone'] as String,
  method: MetaMethod.fromJson(json['method'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PrayerMetaToJson(PrayerMeta instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'timezone': instance.timezone,
      'method': instance.method,
    };

MetaMethod _$MetaMethodFromJson(Map<String, dynamic> json) => MetaMethod(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  params: MethodParams.fromJson(json['params'] as Map<String, dynamic>),
  location: MethodLocation.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MetaMethodToJson(MetaMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'params': instance.params,
      'location': instance.location,
    };

MethodParams _$MethodParamsFromJson(Map<String, dynamic> json) => MethodParams(
  Fajr: (json['Fajr'] as num).toInt(),
  Isha: (json['Isha'] as num).toInt(),
);

Map<String, dynamic> _$MethodParamsToJson(MethodParams instance) =>
    <String, dynamic>{'Fajr': instance.Fajr, 'Isha': instance.Isha};

MethodLocation _$MethodLocationFromJson(Map<String, dynamic> json) =>
    MethodLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$MethodLocationToJson(MethodLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
