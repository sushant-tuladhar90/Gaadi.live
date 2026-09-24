import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../features/scanner/model/vehicle_qr_info_model.dart';

class VehicleQrService {
  static const String baseUrl = 'https://www.gaadi.live/api';

  Future<VehicleQrInfoModel> fetchVehicleQrInfo(String token) async {
    final uri = Uri.parse('$baseUrl/vehicle/qr-info/$token');
    debugPrint('VehicleQrService: request URL = $uri');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    debugPrint('VehicleQrService: response status = ${response.statusCode}');
    debugPrint('VehicleQrService: response body = ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Vehicle QR validation failed: ${response.statusCode}');
    }

    final decodedBody = jsonDecode(response.body);
    if (decodedBody is! Map<String, dynamic>) {
      throw const FormatException('Invalid QR validation response format');
    }

    return VehicleQrInfoModel.fromJson(decodedBody);
  }
}
