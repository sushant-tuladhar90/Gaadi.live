import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/services/vehicle_qr_service.dart';
import '../../routes/view/routes_screen.dart';
import '../presentation/invalid_vehicle_screen.dart';

class ScannerController extends GetxController {
  final VehicleQrService _vehicleQrService = VehicleQrService();

  final RxBool isLoading = false.obs;
  final RxString scannedToken = ''.obs;
  final RxString errorMessage = ''.obs;

  Future<void> validateQrToken(String rawValue) async {
    debugPrint('ScannerController: raw QR value = $rawValue');

    final token = rawValue.trim();
    debugPrint('ScannerController: normalized token = $token');

    if (token.isEmpty) {
      debugPrint('ScannerController: token is empty, redirecting to invalid screen');
      _goToInvalidVehicleScreen();
      return;
    }

    scannedToken.value = token;
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final qrInfo = await _vehicleQrService.fetchVehicleQrInfo(token);
      debugPrint(
        'ScannerController: API result -> success=${qrInfo.success}, canDrive=${qrInfo.data.canDrive}, vehicleName=${qrInfo.data.name}',
      );

      if (qrInfo.success && qrInfo.data.canDrive) {
        final vehicleId = qrInfo.data.id.isNotEmpty ? qrInfo.data.id : qrInfo.data.numberPlate;

        debugPrint('ScannerController: valid QR, navigating to RoutesScreen');
        debugPrint(
          'ScannerController: vehicleId=$vehicleId, vehicleName=${qrInfo.data.name}, operationalRoutes=${qrInfo.data.operationalRoutes.length}',
        );
        Get.offAll(
          () => RoutesScreen(
            vehicleName: qrInfo.data.name,
            vehicleId: vehicleId,
            operationalRoutes: qrInfo.data.operationalRoutes,
          ),
        );
        return;
      }

      debugPrint('ScannerController: QR rejected by backend, redirecting to invalid screen');
      _goToInvalidVehicleScreen();
    } catch (e) {
      debugPrint('ScannerController: validation exception = $e');
      _goToInvalidVehicleScreen();
    } finally {
      isLoading.value = false;
    }
  }

  void _goToInvalidVehicleScreen() {
    Get.offAll(() => const InvalidVehicleScreen());
  }
}
