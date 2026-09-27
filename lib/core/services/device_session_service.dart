import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

class DeviceSessionService {
  DeviceSessionService._();

  static final DeviceSessionService instance = DeviceSessionService._();

  static const String _deviceIdKey = 'device_id';

  Future<String> getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    // String makeDeviceId() => 'gaadi-live-da-${const Uuid().v4()}';

    // if (kDebugMode) {
    //   final debugDeviceId = makeDeviceId();
    //   await prefs.setString(_deviceIdKey, debugDeviceId);
    //   debugPrint('DeviceSessionService: using debug device_id = $debugDeviceId');
    //   return debugDeviceId;
    // }

    // var deviceId = prefs.getString(_deviceIdKey);
    // if (deviceId == null || deviceId.trim().isEmpty) {
    //   deviceId = makeDeviceId();
    //   await prefs.setString(_deviceIdKey, deviceId);
    // }
    


    if (kDebugMode) {
      const debugDeviceId = 'test_sushant';
      await prefs.setString(_deviceIdKey, debugDeviceId);
      debugPrint('DeviceSessionService: using debug device_id = $debugDeviceId');
      return debugDeviceId;
    }

    var deviceId = prefs.getString(_deviceIdKey);
    if (deviceId == null || deviceId.trim().isEmpty) {
      deviceId = 'test_sushant';
      await prefs.setString(_deviceIdKey, deviceId);
    }







    debugPrint('DeviceSessionService: stored device_id = $deviceId');
    return deviceId;
  }

  Future<PermissionStatus> ensureLocationPermission() async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      return status;
    }

    if (status.isDenied || status.isRestricted || status.isLimited) {
      final requested = await Permission.location.request();
      return requested;
    }

    if (status.isPermanentlyDenied) {
      debugPrint('DeviceSessionService: location permission permanently denied; opening settings');
      await openAppSettings();
    }

    return status;
  }

  Future<Map<String, dynamic>> captureSessionPayload({
    required String vehicleId,
    required String routeId,
  }) async {
    final deviceId = await getOrCreateDeviceId();

    final permissionStatus = await ensureLocationPermission();
    final locationStatus = await Geolocator.checkPermission();

    final List<double> fallbackLocation = [0.0, 0.0];
    List<double> location = fallbackLocation;

    if (permissionStatus.isGranted && locationStatus == LocationPermission.whileInUse) {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      debugPrint(
        'DeviceSessionService: permissionStatus=$permissionStatus, geolocatorPermission=$locationStatus, serviceEnabled=$serviceEnabled',
      );

      if (!serviceEnabled) {
        debugPrint('DeviceSessionService: location services are disabled on this device.');
      } else {
        try {
          final position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              timeLimit: Duration(seconds: 15),
            ),
          );

          location = [position.latitude, position.longitude];
          debugPrint(
            'DeviceSessionService: live location captured => lat=${position.latitude}, lng=${position.longitude}',
          );
        } catch (error) {
          debugPrint('DeviceSessionService: unable to get current location: $error');
        }
      }
    } else {
      debugPrint(
        'DeviceSessionService: location permission not granted yet. permissionStatus=$permissionStatus, geolocatorPermission=$locationStatus',
      );
    }

    final payload = <String, dynamic>{
      'device_id': deviceId,
      'vehicle_id': vehicleId,
      'route_id': routeId,
      'location': location,
    };

    final prettyJson = const JsonEncoder.withIndent('    ').convert(payload);
    debugPrint('DeviceSessionPayload: $prettyJson');

    return payload;
  }
}
