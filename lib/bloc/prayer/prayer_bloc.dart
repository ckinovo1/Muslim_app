import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_app/domain/entity/prayer_api.dart';
import 'package:muslim_app/services/prayer_time_service.dart';

part 'prayer_bloc_event.dart';
part 'prayer_bloc_state.dart';

class PrayerBloc extends Bloc<PrayerBlocEvent, PrayerBlocState> {
  final PrayerTimeService prayerService;

  PrayerBloc(this.prayerService) : super(PrayerBlocInitial()) {
    on<PrayerBlocEvent>((event, emit) async {
      emit(PrayerLoading());
      try {
        final result = await prayerService.getPrayerTimes();
        if (result != null) {
          emit(PrayerLoaded(result));
        } else {
          emit(const PrayerError('Не удалось получить данные молитв'));
        }
      } catch (e) {
        emit(PrayerError(e.toString()));
      }
    });
  }
}
