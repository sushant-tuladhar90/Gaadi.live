import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../core/services/device_validity_service.dart';

class DeviceCheckController extends GetxController {
  final DeviceValidityService _deviceValidityService = DeviceValidityService();

  /// How long the check may run before the loading button is shown.
  static const Duration _slowThreshold = Duration(milliseconds: 1500);

  final RxBool isChecking = false.obs;
  final RxBool isSlow = false.obs;
  final RxString errorMessage = ''.obs;

  Timer? _slowTimer;

  @override
  void onReady() {
    super.onReady();
    checkDevice();
  }

  @override
  void onClose() {
    _slowTimer?.cancel();
    super.onClose();
  }

  Future<void> checkDevice() async {
    if (isChecking.value) {
      return;
    }

    isChecking.value = true;
    isSlow.value = false;
    errorMessage.value = '';
    _slowTimer?.cancel();
    _slowTimer = Timer(_slowThreshold, () => isSlow.value = true);

    try {
      final appInfo = await _deviceValidityService.getDriverAppInfo();
      final result = await _deviceValidityService.checkDeviceIdValid(appInfo.deviceId);
      debugPrint(
        'DeviceCheckController: API result -> success=${result.success}, isValid=${result.isValid}, deviceId=${appInfo.deviceId}',
      );

      if (result.success && result.isValid) {
        Get.offAllNamed(AppRoutes.scanner);
      } else {
        Get.offAllNamed(AppRoutes.registerDevice, arguments: appInfo);
      }
    } catch (e) {
      debugPrint('DeviceCheckController: device check exception = $e');
      errorMessage.value = 'Could not verify this device. Check your connection and try again.';
    } finally {
      _slowTimer?.cancel();
      isChecking.value = false;
    }
  }
}
