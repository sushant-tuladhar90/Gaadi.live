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

