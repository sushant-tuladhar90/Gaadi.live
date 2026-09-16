import 'package:flutter/material.dart';

class HomeContent {
  const HomeContent({
    required this.gpsLocation,
    required this.telemetry,
    required this.title,
    required this.description,
    required this.badges,
    required this.imageAsset,
  });

  final String gpsLocation;
  final String telemetry;
  final String title;
  final String description;
  final List<HomeBadge> badges;
  final String imageAsset;
}

class HomeBadge {
  const HomeBadge({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
