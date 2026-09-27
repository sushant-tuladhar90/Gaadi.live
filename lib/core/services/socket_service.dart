import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class SocketService {
  SocketService._();

  static final SocketService instance = SocketService._();

  socket_io.Socket? _socket;

  socket_io.Socket get socket {
    if (_socket == null) {
      throw StateError('Socket has not been initialized. Call connect() first.');
    }

    return _socket!;
  }

  Future<void> connect() async {
    if (_socket?.connected == true) {
      debugPrint('SocketService: already connected');
      return;
    }

    const socketUrl = 'https://www.gaadi.live';

    debugPrint('SocketService: connecting to $socketUrl');

    _socket = socket_io.io(
      socketUrl,
      socket_io.OptionBuilder()
          .setPath('/ws')
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableReconnection()
          .build(),
    );

    _socket!.onConnect((_) {
      debugPrint('SocketService: CONNECTED');
      debugPrint('SocketService: socket id = ${_socket!.id}');
    });

    _socket!.onConnectError((data) {
      debugPrint('SocketService: CONNECT ERROR => $data');
    });

    _socket!.onError((data) {
      debugPrint('SocketService: ERROR => $data');
    });

    _socket!.onDisconnect((reason) {
      debugPrint('SocketService: DISCONNECTED => $reason');
    });

    _socket!.onAny((event, data) {
      debugPrint('SocketService: [$event] => $data');
    });

    _socket!.connect();
  }

  void emitDriverLocation({
    required String deviceId,
    required String vehicleId,
    required String routeId,
    required List<double> location,
  }) {
    if (_socket == null || !_socket!.connected) {
      debugPrint('SocketService: cannot emit driver location because socket is not connected');
      return;
    }

    final payload = <String, dynamic>{
      'device_id': deviceId,
      'vehicle_id': vehicleId,
      'route_id': routeId,
      'location': location,
    };

    final prettyJson = const JsonEncoder.withIndent('    ').convert(payload);
    debugPrint('SocketService: emitting payload to driver-app');
    debugPrint('SocketService: payload =>\n$prettyJson');

    _socket!.emitWithAck(
      'driver-app',
      payload,
      ack: (data) {
        final ackPretty = const JsonEncoder.withIndent('    ').convert(data);
        debugPrint('SocketService: ACK received from driver-app =>\n$ackPretty');
      },
    );
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}