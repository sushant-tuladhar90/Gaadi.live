import 'package:flutter/material.dart';

import '../data/home_content.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel()
      : content = const HomeContent(
          gpsLocation: 'GPS\n34.0522° N, 118.2437° W',
          telemetry: 'Speed: 248 KM/H\nBattery: 512 KM\nRange: 512 KM',
          title: 'Track Every Mile, Every\nSecond in Real Time',
          description: 'Monitor fleet speed, live coordinates, battery health,\nand instant geofence alerts with sub-second accuracy\nacross any territory.',
          imageAsset: 'assets/onboarding_image.png',
          badges: [
            HomeBadge(label: '99.9% Uptime', icon: Icons.settings_outlined),
            HomeBadge(label: 'Sub-second Sync', icon: Icons.sync_outlined),
            HomeBadge(label: 'Global Satellite Mesh', icon: Icons.gps_fixed_outlined),
          ],
        );

  final HomeContent content;
  bool _hasStarted = false;

  bool get hasStarted => _hasStarted;

  void startExperience() {
    if (_hasStarted) {
      return;
    }

    _hasStarted = true;
    notifyListeners();
  }
}
