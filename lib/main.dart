export 'app/app.dart';

import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/services/device_session_service.dart';
import 'core/services/socket_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DeviceSessionService.instance.getOrCreateDeviceId();
  await SocketService.instance.connect();
  runApp(const GaadiLiveApp());
}
