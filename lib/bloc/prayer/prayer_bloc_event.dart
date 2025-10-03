part of 'prayer_bloc.dart';

sealed class PrayerBlocEvent extends Equatable {
  const PrayerBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadPrayerTimes extends PrayerBlocEvent{}