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
        title: const Text("Время намазов",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
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
            return _PrayerListView(data: state.data);
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _PrayerListView extends StatelessWidget {
  final dynamic data;
  const _PrayerListView({required this.data});

  @override
  Widget build(BuildContext context) {
    final timings = data.data.timings;

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
          hour: int.tryParse(parts[0]) ?? 0, minute: int.tryParse(parts[1]) ?? 0);
      if (_isAfter(now, prayerTime)) {
        nextPrayerName = entry.key;
        nextPrayerTime = entry.value;
        break;
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          data.data.date.readable,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 12),
        if (nextPrayerName != null)
          NextPrayerCard(name: nextPrayerName, time: nextPrayerTime!),
        const SizedBox(height: 16),
        ...prayers.entries
            .map((e) => PrayerListTile(name: e.key, time: e.value))
            .toList(),
      ],
    );
  }

  bool _isAfter(TimeOfDay now, TimeOfDay prayer) {
    if (prayer.hour > now.hour) return true;
    if (prayer.hour == now.hour && prayer.minute > now.minute) return true;
    return false;
  }
}

class NextPrayerCard extends StatelessWidget {
  final String name;
  final String time;
  const NextPrayerCard({required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade700,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Следующая молитва", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          Text("$name - $time",
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}

class PrayerListTile extends StatelessWidget {
  final String name;
  final String time;
  const PrayerListTile({required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
      trailing: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black),
        height: 30,
        width: 60,
        child: Center(
            child: Text(time,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green))),
      ),
    );
  }
}
