import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:go_router/go_router.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>?> menuItems = [
      {
        "title": "Азкары",
        "color": const Color.fromARGB(255, 61, 168, 255),
        "icon": FlutterIslamicIcons.tasbihHand,
        "route": "/azkar",
      },
      {
        "title": "Коран",
        "color": const Color.fromARGB(255, 51, 250, 61),
        "icon": FlutterIslamicIcons.quran2,
        "route": "/quran",
      },
      {
        "title": "Кибла",
        "color": const Color.fromARGB(221, 255, 216, 41),
        "icon": FlutterIslamicIcons.solidQibla,
        "route": "/qibla",
      },
      {
        "title": "Дуа",
        "color": const Color.fromARGB(255, 61, 168, 255),
        "icon": FlutterIslamicIcons.prayingPerson,
        "route": "/tasbeeh",
      },
      {
        "title": "Сунна намаз",
        "color": const Color.fromARGB(255, 51, 250, 61),
        "icon": FlutterIslamicIcons.kowtow,
        "route": "/sunnah",
      },
      {
        "title": "Календарь",
        "color": const Color.fromARGB(221, 255, 216, 41),
        "icon": FlutterIslamicIcons.islam,
        "route": "/calendar",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Дополнительно",
          style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold ),
        ),
        backgroundColor: const Color.fromARGB(0, 29, 27, 27),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.75,

          children: menuItems.map((item) {
            return ElevatedButton(
              onPressed: () {
                context.go(item["route"]!);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: item!["color"]!,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item["icon"], size: 40, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    item["title"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
