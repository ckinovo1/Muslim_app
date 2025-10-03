import 'package:flutter/material.dart';
import 'package:muslim_app/ui/navigation/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return MaterialApp.router(
      
      routerConfig: _appRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
