import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scanner_view.dart';
import '../data/scanner_content.dart';
import '../../routes/presentation/routes_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final MobileScannerController _cameraController;
  late final ScannerContent _content;
  bool _isScanning = false;
  bool _isRearLens = true;
  bool _isTorchOn = false;
  String? _detectedValue;

  @override
  void initState() {
    super.initState();
    _cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    _content = const ScannerContent(
      title: 'Scan Vehicle QR Code',
      description: 'Align the QR code located on your vehicle tracker\nOBD-II unit, dashboard, or driver card.',
      status: 'LIVE SENSOR 60FPS',
      deviceName: 'TrackPulse OBD-v4 (Proximity: Near)',
      signalStrength: '-64 dBm',
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScannerView(
      content: _content,
      isScanning: _isScanning,
      isRearLens: _isRearLens,
      isTorchOn: _isTorchOn,
      detectedValue: _detectedValue,
      cameraController: _cameraController,
      onScan: _startScanning,
      onDetection: _handleDetection,
      onToggleTorch: _toggleTorch,
      onSwitchLens: _switchLens,
      onRecenter: _recenter,
    );
  }

  void _startScanning() {
    setState(() => _isScanning = true);
  }

  void _handleDetection(BarcodeCapture capture) {
    final value = capture.barcodes
        .map((barcode) => barcode.rawValue)
        .whereType<String>()
        .firstOrNull;

    if (value == null || value == _detectedValue) {
      return;
    }

    setState(() {
      _detectedValue = value;
      _isScanning = false;
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const RoutesScreen()),
    );
  }

  void _toggleTorch() {
    _isTorchOn = !_isTorchOn;
    _cameraController.toggleTorch();
    setState(() {});
  }

  void _switchLens() {
    _isRearLens = !_isRearLens;
    _cameraController.switchCamera();
    setState(() {});
  }

  void _recenter() {
    setState(() {
      _isScanning = false;
      _detectedValue = null;
    });
  }
}
