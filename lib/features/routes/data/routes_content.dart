import 'package:flutter/material.dart';

class RoutesContent {
  const RoutesContent({
    required this.vehicleId,
    required this.routes,
  });

  final String vehicleId;
  final List<RouteProfile> routes;
}

class RouteProfile {
  const RouteProfile({
    required this.title,
    required this.eta,
    required this.distance,
    required this.tolls,
    required this.lastLabel,
    required this.lastValue,
    required this.trafficLabel,
    required this.trafficColor,
    required this.accentColor,
    this.isSelected = false,
    this.badgeLabel,
    this.badgeColor,
  });

  final String title;
  final String eta;
  final String distance;
  final String tolls;
  final String lastLabel;
  final String lastValue;
  final String trafficLabel;
  final Color trafficColor;
  final Color accentColor;
  final bool isSelected;
  final String? badgeLabel;
  final Color? badgeColor;
}

const defaultRoutesContent = RoutesContent(
  vehicleId: 'TRK-8821',
  routes: [
    RouteProfile(
      title: 'Route 4A - Downtown Corridor',
      eta: '34 m',
      distance: '18.4 mi',
      tolls: '\$0',
      lastLabel: 'EFF',
      lastValue: '92%',
      trafficLabel: 'Mod Traffic',
      trafficColor: Color(0xFFFFB51B),
      accentColor: Color(0xFF61E9BA),
      isSelected: true,
      badgeLabel: 'DEFAULT ASSIGNED',
      badgeColor: Color(0xFF58E9F0),
    ),
    RouteProfile(
      title: 'I-90 Express Flyover',
      eta: '28 m',
      distance: '19.1 mi',
      tolls: '\$2.40',
      lastLabel: 'DISPATCH',
      lastValue: 'REC',
      trafficLabel: 'Clear',
      trafficColor: Color(0xFF61E9BA),
      accentColor: Color(0xFF61E9BA),
      badgeLabel: '-6 MIN FASTEST',
      badgeColor: Color(0xFF61E9BA),
    ),
    RouteProfile(
      title: 'US-101 Freight Bypass',
      eta: '32 m',
      distance: '17.6 mi',
      tolls: '\$0',
      lastLabel: 'SAVINGS',
      lastValue: '1.2 gal',
      trafficLabel: 'Smooth',
      trafficColor: Color(0xFF61E9BA),
      accentColor: Color(0xFF61E9BA),
      badgeLabel: '-14% ENERGY',
      badgeColor: Color(0xFF61E9BA),
    ),
    RouteProfile(
      title: 'Industrial Parkway Arterial',
      eta: '39 m',
      distance: '20.2 mi',
      tolls: '\$0',
      lastLabel: 'AVG SPEED',
      lastValue: '31 mph',
      trafficLabel: 'Heavy St.',
      trafficColor: Color(0xFFFFB5B5),
      accentColor: Color(0xFFB7C2CE),
      badgeLabel: 'ZERO TOLLS',
      badgeColor: Color(0xFFB7C2CE),
    ),
  ],
);
