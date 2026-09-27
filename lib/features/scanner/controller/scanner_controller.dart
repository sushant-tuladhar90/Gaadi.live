import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../core/services/vehicle_qr_service.dart';

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
      debugPrint('ScannerController: token is empty; invalid QR, staying on scanner');
      _goToInvalidVehicleScreen();
      return;
    }

    scannedToken.value = token;
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final qrInfo = await _vehicleQrService.fetchVehicleQrInfo(token);
      debugPrint(
        'ScannerController: API result -> success=${qrInfo.success}, canDrive=${qrInfo.data.canDrive}, vehicleName=${qrInfo.data.name}, vehicleId=${qrInfo.data.id}',
      );

      final isValidVehicle = qrInfo.success &&
          qrInfo.data.canDrive &&
          qrInfo.data.id.trim().isNotEmpty &&
          qrInfo.data.name.trim().isNotEmpty;

      if (!isValidVehicle) {
        debugPrint('ScannerController: QR rejected by backend or missing required vehicle data; redirecting to invalid screen');
        _goToInvalidVehicleScreen();
        return;
      }

      final vehicleId = qrInfo.data.id.trim();

      debugPrint('ScannerController: valid QR, navigating to RoutesScreen');
      debugPrint(
        'ScannerController: vehicleId=$vehicleId, vehicleName=${qrInfo.data.name}, operationalRoutes=${qrInfo.data.operationalRoutes.length}',
      );
      Get.offAllNamed(
        AppRoutes.routes,
        arguments: {
          'vehicleName': qrInfo.data.name,
          'vehicleId': vehicleId,
          'operationalRoutes': qrInfo.data.operationalRoutes,
        },
      );
    } catch (e) {
      debugPrint('ScannerController: validation exception = $e');
      _goToInvalidVehicleScreen();
    } finally {
      isLoading.value = false;
    }
  }

  void _goToInvalidVehicleScreen() {
    Get.offAllNamed(AppRoutes.invalidVehicle);
  }
}
