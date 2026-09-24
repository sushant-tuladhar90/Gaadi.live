import 'package:flutter/material.dart';

class RouteModel {
  const RouteModel({
    required this.title,
    required this.eta,
    required this.distance,
    required this.tolls,
    required this.trafficLabel,
    required this.trafficColor,
    required this.accentColor,
    required this.isSelected,
    this.badgeLabel,
    this.badgeColor,
  });

  final String title;
  final String eta;
  final String distance;
  final String tolls;
  final String trafficLabel;
  final Color trafficColor;
  final Color accentColor;
  final bool isSelected;
  final String? badgeLabel;
  final Color? badgeColor;
}
