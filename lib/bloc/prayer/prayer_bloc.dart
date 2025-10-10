import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_app/data/services/prayer_time_service.dart';
import 'package:muslim_app/data/services/notification_service.dart';

part 'prayer_bloc_event.dart';
part 'prayer_bloc_state.dart';

class PrayerBloc extends Bloc<PrayerBlocEvent, PrayerBlocState> {
  final PrayerTimeService prayerService;
  final NotificationService notificationService;

  PrayerBloc({
    required this.prayerService,
    required this.notificationService,
  }) : super(PrayerBlocInitial()) {
    on<LoadPrayerTimes>(_onLoadPrayerTimes);
  }

  Future<void> _onLoadPrayerTimes(
      LoadPrayerTimes event, Emitter<PrayerBlocState> emit) async {
    emit(PrayerLoading());

    try {
      final result = await prayerService.getPrayerTimes();
      if (result == null) {
        emit(const PrayerError('Не удалось получить данные молитв'));
        return;
      }

      final prayersMap = <String, String>{
        'Фаджр': result.fajr,
        'Восход': result.sunrise,
        'Зухр': result.dhuhr,
        'Аср': result.asr,
        'Магриб': result.maghrib,
        'Иша': result.isha,
        'Духа': result.duha,
        'Тахаджуд': result.tahajjud,
      };

try {
  await notificationService.initialize();
} catch (e) {
  print('Ошибка инициализации уведомлений: $e');
}      await notificationService.schedulePrayerNotifications(result);

      emit(PrayerLoaded(prayersMap));
    } catch (e) {
      emit(PrayerError('Ошибка при загрузке молитв: $e'));
    }
  }
}
