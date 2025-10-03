// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getIndex(location),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/prayer');
              break;
            case 1:
              context.go('/service');
              break;
               case 2:
              context.go('/settings');
              break;
           
          }
        },

         items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Prayer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.now_widgets_rounded),
            label: "Service",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],iconSize: 40,
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white70,
      ),
    );
  }

  int _getIndex(String location) {
    if (location.startsWith('/service')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }
}
