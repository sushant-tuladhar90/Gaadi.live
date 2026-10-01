export 'app/app.dart';

import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/services/background_location_service.dart';
import 'core/services/device_session_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DeviceSessionService.instance.getOrCreateDeviceId();
  await BackgroundLocationService.initialize();
  runApp(const GaadiLiveApp());
}
