part of 'prayer_bloc.dart';

abstract class PrayerBlocState extends Equatable {
  const PrayerBlocState();
  
  @override
  List<Object?> get props => [];
}

 class PrayerBlocInitial extends PrayerBlocState {}

class PrayerLoading extends PrayerBlocState{}

class PrayerLoaded extends PrayerBlocState{
  final PrayerApi data;

  const PrayerLoaded(this.data);

   @override
  List<Object?> get props => [data];
}

class PrayerError extends PrayerBlocState{
  final String message;

  const PrayerError(this.message);

@override
  List<Object?> get props => [message];

  
}
