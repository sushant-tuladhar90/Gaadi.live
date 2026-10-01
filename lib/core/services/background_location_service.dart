import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'device_session_service.dart';
import 'socket_service.dart';

/// Keeps sending driver-location heartbeats to the server via a foreground
/// service, so updates keep flowing even after the app is minimized or the
/// OS decides to reclaim the UI isolate.
class BackgroundLocationService {
  BackgroundLocationService._();

  static const _notificationId = 888;
  static const _vehicleIdKey = 'bg_tracking_vehicle_id';
  static const _routeIdKey = 'bg_tracking_route_id';

  static Future<void> initialize() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        autoStart: false,
        isForegroundMode: true,
        // Leave notificationChannelId unset so the plugin creates its own
        // channel; a custom id must be created beforehand or Android rejects
        // the notification with "Bad notification for startForeground".
        foregroundServiceTypes: [AndroidForegroundType.location],
        initialNotificationTitle: 'Gaadi Live',
        initialNotificationContent: 'Sharing your live location',
        foregroundServiceNotificationId: _notificationId,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: _onStart,
        onBackground: _onIosBackground,
      ),
    );
  }

  static Future<void> start({
    required String vehicleId,
    required String routeId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_vehicleIdKey, vehicleId);
    await prefs.setString(_routeIdKey, routeId);

    final service = FlutterBackgroundService();

    if (await service.isRunning()) {
      service.invoke('setRouteData', {'vehicleId': vehicleId, 'routeId': routeId});
      return;
    }

    await service.startService();
  }

  static Future<void> stop() async {
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      service.invoke('stopService');
    }
  }
}

@pragma('vm:entry-point')
Future<bool> _onIosBackground(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void _onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  var vehicleId = prefs.getString('bg_tracking_vehicle_id') ?? '';
  var routeId = prefs.getString('bg_tracking_route_id') ?? '';

  Timer? heartbeatTimer;

  service.on('setRouteData').listen((event) {
    vehicleId = event?['vehicleId'] as String? ?? vehicleId;
    routeId = event?['routeId'] as String? ?? routeId;
  });

  service.on('stopService').listen((event) {
    heartbeatTimer?.cancel();
    SocketService.instance.disconnect();
    service.stopSelf();
  });

  Future<void> sendHeartbeat() async {
    if (vehicleId.isEmpty || routeId.isEmpty) {
      debugPrint('BackgroundLocationService: skipping heartbeat, no active vehicle/route yet');
      return;
    }

    await SocketService.instance.connect();

    final payload = await DeviceSessionService.instance.captureSessionPayload(
      vehicleId: vehicleId,
      routeId: routeId,
    );

    SocketService.instance.emitDriverLocation(
      deviceId: payload['device_id'] as String,
      vehicleId: payload['vehicle_id'] as String,
      routeId: payload['route_id'] as String,
      location: (payload['location'] as List)
          .map((item) => (item as num).toDouble())
          .toList(),
    );

    if (service is AndroidServiceInstance && await service.isForegroundService()) {
      final now = DateTime.now();
      final hh = now.hour.toString().padLeft(2, '0');
      final mm = now.minute.toString().padLeft(2, '0');
      final ss = now.second.toString().padLeft(2, '0');
      service.setForegroundNotificationInfo(
        title: 'Gaadi Live — sharing your location',
        content: 'Last update sent $hh:$mm:$ss',
      );
    }
  }

  await sendHeartbeat();
  heartbeatTimer = Timer.periodic(const Duration(seconds: 5), (_) => sendHeartbeat());
}
