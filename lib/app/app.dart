import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';
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
      initialRoute: AppRoutes.deviceCheck,
      getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
    );
  }
}
