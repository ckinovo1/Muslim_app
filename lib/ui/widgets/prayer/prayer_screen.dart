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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '🕌 Время намазов',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PrayerBloc, PrayerBlocState>(
        builder: (context, state) {
          if (state is PrayerLoading || state is PrayerBlocInitial) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          }

          if (state is PrayerError) {
            return Center(
              child: Text(
                'Ошибка: ${state.message}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          if (state is PrayerLoaded) {
            return _PrayerListView(prayers: state.prayers);
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _PrayerListView extends StatelessWidget {
  final Map<String, String> prayers;
  const _PrayerListView({required this.prayers});

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();

    MapEntry<String, String>? nextPrayer;
    for (var entry in prayers.entries) {
      final parts = entry.value.split(':');
      final prayerTime =
          TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      if (_isAfter(now, prayerTime)) {
        nextPrayer = entry;
        break;
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (nextPrayer != null)
          NextPrayerCard(name: nextPrayer.key, time: nextPrayer.value),
        const SizedBox(height: 20),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Следующая молитва",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              "$name - $time",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.w600,
            fontSize: 18),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          time,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
