import 'package:flutter/material.dart';

import '../../scanner/model/vehicle_qr_info_model.dart';

class RoutesContent {
  const RoutesContent({
    required this.vehicleId,
    required this.routes,
    this.vehicleName,
  });

  final String vehicleId;
  final String? vehicleName;
  final List<RouteProfile> routes;

  factory RoutesContent.fromOperationalRoutes({
    required String vehicleId,
    required String? vehicleName,
    required List<OperationalRoute> operationalRoutes,
  }) {
    final routes = operationalRoutes.asMap().entries.map((entry) {
      final index = entry.key;
      final route = entry.value;
      final citiesLabel = route.cities.isNotEmpty ? route.cities.join(' • ') : null;

      return RouteProfile(
        id: route.id,
        title: route.name.isNotEmpty ? route.name : 'Operational Route ${index + 1}',
        eta: '',
        distance: '',
        tolls: '',
        lastLabel: '',
        lastValue: '',
        trafficLabel: citiesLabel ?? '',
        trafficColor: const Color(0xFF61E9BA),
        accentColor: const Color(0xFF61E9BA),
        isSelected: index == 0,
        badgeLabel: citiesLabel,
        badgeColor: const Color(0xFF58E9F0),
      );
    }).toList();

    return RoutesContent(
      vehicleId: vehicleId,
      vehicleName: vehicleName,
      routes: routes,
    );
  }
}

class RouteProfile {
  const RouteProfile({
    required this.id,
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

  final String id;
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
  vehicleName: 'Gaadi Live',
  routes: [
    RouteProfile(
      id: 'default-route-1',
      title: 'Biratnagar - Kathmandu',
      eta: '10 m',
      distance: '525 km',
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
      id: 'default-route-2',
      title: 'Biratnagar - Pokhara',
      eta: '28 m',
      distance: '19.1 mi',
      tolls: '\$2.40',
      lastLabel: 'DISPATCH',
      lastValue: 'REC',
      trafficLabel: 'Clear',
      trafficColor: Color(0xFF61E9BA),
      accentColor: Color(0xFF61E9BA),
      badgeLabel: 'RECOMMENDED',
      badgeColor: Color(0xFF61E9BA),
    ),
    RouteProfile(
      id: 'default-route-3',
      title: 'Biratnagar - Butwal',
      eta: '32 m',
      distance: '17.6 mi',
      tolls: '\$0',
      lastLabel: 'SAVINGS',
      lastValue: '1.2 gal',
      trafficLabel: 'Smooth',
      trafficColor: Color(0xFF61E9BA),
      accentColor: Color(0xFF61E9BA),
      badgeLabel: 'RECOMMENDED',
      badgeColor: Color(0xFF61E9BA),
    ),
    RouteProfile(
      id: 'default-route-4',
      title: 'Biratnagar - Janakpur',
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
