part of 'prayer_bloc.dart';

abstract class PrayerBlocState extends Equatable {
  const PrayerBlocState();

  @override
  List<Object?> get props => [];
}

class PrayerBlocInitial extends PrayerBlocState {}

class PrayerLoading extends PrayerBlocState {}

class PrayerLoaded extends PrayerBlocState {
  final Map<String, String> prayers;

  const PrayerLoaded(this.prayers);

  @override
  List<Object?> get props => [prayers];
}

class PrayerError extends PrayerBlocState {
  final String message;

  const PrayerError(this.message);

  @override
  List<Object?> get props => [message];
}

