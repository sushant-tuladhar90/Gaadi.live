import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import '../../features/device_check/model/device_validity_model.dart';
import 'device_session_service.dart';

class DeviceValidityService {
  static const String baseUrl = 'https://www.gaadi.live/api';

  // TODO: set to false once /api/is-device-id-valid exists on the backend.
  static const bool _useDummyResponse = true;

  Future<DeviceValidityModel> checkDeviceIdValid(String deviceId) async {
    final uri = Uri.parse('$baseUrl/is-device-id-valid').replace(
      queryParameters: {'device_id': deviceId},
    );
    debugPrint('DeviceValidityService: request URL = $uri');

    if (_useDummyResponse) {
      debugPrint('DeviceValidityService: using dummy response -> is_valid=false');
      return DeviceValidityModel.fromJson(const {
        'success': true,
        'data': {'is_valid': false},
      });
    }

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    debugPrint('DeviceValidityService: response status = ${response.statusCode}');
    debugPrint('DeviceValidityService: response body = ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Device validity check failed: ${response.statusCode}');
    }

    final decodedBody = jsonDecode(response.body);
    if (decodedBody is! Map<String, dynamic>) {
      throw const FormatException('Invalid device validity response format');
    }

    return DeviceValidityModel.fromJson(decodedBody);
  }

  Future<DriverAppInfo> getDriverAppInfo() async {
    final deviceId = await DeviceSessionService.instance.getOrCreateDeviceId();
    final packageInfo = await PackageInfo.fromPlatform();

    return DriverAppInfo(
      deviceId: deviceId,
      platform: Platform.isIOS ? 'iOS' : 'Android',
      appVersion: '${packageInfo.version}+${packageInfo.buildNumber}',
    );
  }
}
