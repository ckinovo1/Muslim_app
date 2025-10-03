import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_app/bloc/prayer/prayer_bloc.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PrayerBloc>().add(LoadPrayerTimes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text("Время намазов",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold ),
        ),
        backgroundColor: const Color.fromARGB(0, 32, 37, 32),
      ),
      body: BlocBuilder<PrayerBloc, PrayerBlocState>(
        builder: (context, state) {
          if (state is PrayerLoading || state is PrayerBlocInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PrayerError) {
            return Center(child: Text("Ошибка: ${state.message}"));
          }

          if (state is PrayerLoaded) {
            final timings = state.data.data.timings;

            final prayers = {
              "Фаджр": timings.fajr,
              "Восход": timings.sunrise,
              "Зухр": timings.dhuhr,
              "Аср": timings.asr,
              "Магриб": timings.maghrib,
              "Иша": timings.isha,
            };

            final now = TimeOfDay.now();
            String? nextPrayerName;
            String? nextPrayerTime;
            for (var entry in prayers.entries) {
              final parts = entry.value.split(":");
              final prayerTime = TimeOfDay(
                hour: int.tryParse(parts[0]) ?? 0,
                minute: int.tryParse(parts[1]) ?? 0,
              );
              if (_isAfter(now, prayerTime)) {
                nextPrayerName = entry.key;
                nextPrayerTime = entry.value;
                break;
              }
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // дата
                Text(
                  state.data.data.date.readable,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                  ),
                ),
                const SizedBox(height: 12),

                // блок Next Prayer
                if (nextPrayerName != null)
                  Card(
                    color: Colors.green.shade700,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Следующая молитва",
                              style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 6),
                          Text(
                            "$nextPrayerName - $nextPrayerTime",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                ...prayers.entries.map(
                  (e) => ListTile(
                    title: Text(e.key,style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 18),),
                    trailing: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black),
                      height: 30,
                      width: 60,
                      child: Center(
                        
                        child: Text(
                          e.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  bool _isAfter(TimeOfDay now, TimeOfDay prayer) {
    if (prayer.hour > now.hour) return true;
    if (prayer.hour == now.hour && prayer.minute > now.minute) return true;
    return false;
  }
}
