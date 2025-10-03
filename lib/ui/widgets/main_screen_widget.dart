// import 'package:flutter/material.dart';
// import 'package:muslim_app/domain/api_client/prayer_time_api_client.dart';
// import 'package:muslim_app/domain/entity/prayer_api.dart';
// import 'package:muslim_app/services/prayer_time_service.dart';

// class MainScreenWidget extends StatefulWidget {
//   const MainScreenWidget({super.key});

//   @override
//   State<MainScreenWidget> createState() => _MainScreenWidgetState();
// }

// class _MainScreenWidgetState extends State<MainScreenWidget> {
// late PrayerTimeService _prayerTimeService;
// PrayerApi? _prayerApi;


//   @override
//   Widget build(BuildContext context) {
//     final _apiClient = AladhanApiClient();

//     return Scaffold(
//       backgroundColor: Colors.white70,
//       body: FutureBuilder<PrayerApi>(
//         future: _apiClient.getPrayerTimesByCity(
//           city: 'London',
//           country: 'UK',
//           method: 2,
//         ),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text("Ошибка: ${snapshot.error}"));
//           }
//           if (snapshot.hasData) {
//             final timings = snapshot.data!.data.timings;

//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Сегодня',
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text(
//                           'Сменить тему',
//                           style: TextStyle(color: Colors.green, fontSize: 15),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15, 
//                     vertical: 10,
//                   ),

//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     height: 400,
//                     child: Column(
//                       children: [
//                         Row(), 
//                         Row(children: [Text('Фаджр: ${timings.fajr}')]),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//           return const Center(
//             child: Text('Nothing'),
//           );
//         },
//       ),
//     );
//   }
// }
