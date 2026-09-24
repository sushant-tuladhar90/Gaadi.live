import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/home/presentation/home_screen.dart';
import 'theme.dart';

class GaadiLiveApp extends StatelessWidget {
  const GaadiLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gaadi Live',
      debugShowCheckedModeBanner: false,
      theme: GaadiLiveTheme.lightTheme,
      darkTheme: GaadiLiveTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
