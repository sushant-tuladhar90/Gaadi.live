import 'dart:convert';

class DeviceValidityModel {
  const DeviceValidityModel({
    required this.success,
    required this.isValid,
  });

  final bool success;
  final bool isValid;

  factory DeviceValidityModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? <String, dynamic>{};

    return DeviceValidityModel(
      success: json['success'] as bool? ?? false,
      isValid: data['is_valid'] as bool? ?? false,
    );
  }
}

/// Details encoded into the register-device QR code.
class DriverAppInfo {
  const DriverAppInfo({
    required this.deviceId,
    required this.platform,
    required this.appVersion,
  });

  final String deviceId;
  final String platform;
  final String appVersion;

  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
        'platform': platform,
        'app_version': appVersion,
      };

  String toQrData() => jsonEncode(toJson());
}
