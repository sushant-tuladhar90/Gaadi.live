import 'package:get/get.dart';

import '../features/home/presentation/home_screen.dart';
import '../features/routes/presentation/emergency_stop_page.dart';
import '../features/routes/presentation/routes_screen.dart';
import '../features/scanner/model/vehicle_qr_info_model.dart';
import '../features/scanner/presentation/invalid_vehicle_screen.dart';
import '../features/scanner/presentation/scanner_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/home';
  static const String scanner = '/scanner';
  static const String invalidVehicle = '/invalid-vehicle';
  static const String routes = '/routes';
  static const String emergencyStop = '/emergency-stop';
}

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.scanner,
      page: () => const ScannerScreen(),
    ),
    GetPage(
      name: AppRoutes.invalidVehicle,
      page: () => const InvalidVehicleScreen(),
    ),
    GetPage(
      name: AppRoutes.routes,
      page: () {
        final args = Get.arguments ?? <String, dynamic>{};
        return RoutesScreen(
          vehicleName: args['vehicleName'] as String?,
          vehicleId: args['vehicleId'] as String?,
          operationalRoutes: (args['operationalRoutes'] as List<dynamic>?)
                  ?.map((item) => item as OperationalRoute)
                  .toList() ??
              const <OperationalRoute>[],
        );
      },
    ),
    GetPage(
      name: AppRoutes.emergencyStop,
      page: () {
        final args = Get.arguments ?? <String, dynamic>{};
        return EmergencyStopPage(
          vehicleId: args['vehicleId'] as String?,
          vehicleName: args['vehicleName'] as String?,
          routeId: args['routeId'] as String? ?? '',
        );
      },
    ),
  ];
}
