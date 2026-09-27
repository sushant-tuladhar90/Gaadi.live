import 'package:flutter/material.dart';

import '../../scanner/model/vehicle_qr_info_model.dart';
import '../../scanner/view/scanner_screen.dart';
import '../data/routes_content.dart';
import 'routes_view.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({
    super.key,
    this.vehicleName,
    this.vehicleId,
    this.operationalRoutes,
  });

  final String? vehicleName;
  final String? vehicleId;
  final List<OperationalRoute>? operationalRoutes;

  @override
  Widget build(BuildContext context) {
    final routes = (operationalRoutes != null && operationalRoutes!.isNotEmpty)
        ? RoutesContent.fromOperationalRoutes(
            vehicleId: vehicleId ?? '',
            vehicleName: vehicleName,
            operationalRoutes: operationalRoutes!,
          )
        : RoutesContent(
            vehicleId: vehicleId ?? '',
            vehicleName: vehicleName,
            routes: const [],
          );

    return RoutesView(
      content: routes,
      onScan: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const ScannerScreen()),
        );
      },
    );
  }
}
