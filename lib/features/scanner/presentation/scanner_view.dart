import 'package:flutter/material.dart';
import 'package:gaadi_live/features/routes/presentation/routes_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../app/responsive.dart';
import '../data/scanner_content.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({
    required this.content,
    required this.isScanning,
    required this.isRearLens,
    required this.isTorchOn,
    required this.detectedValue,
    required this.cameraController,
    required this.onScan,
    required this.onDetection,
    required this.onToggleTorch,
    required this.onSwitchLens,
    required this.onRecenter,
    super.key,
  });

  final ScannerContent content;
  final bool isScanning;
  final bool isRearLens;
  final bool isTorchOn;
  final String? detectedValue;
  final MobileScannerController cameraController;
  final VoidCallback onScan;
  final ValueChanged<BarcodeCapture> onDetection;
  final VoidCallback onToggleTorch;
  final VoidCallback onSwitchLens;
  final VoidCallback onRecenter;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final background = const Color(0xFF070B12);
    final textPrimary = const Color(0xFFE9EEF8);
    final textSecondary = const Color(0xFFB6C1CD);
    final accent = const Color(0xFF00E5F2);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Responsive.height(90).clamp(620.0, 820.0),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                MobileScanner(
                                  controller: cameraController,
                                  onDetect: onDetection,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error) => _CameraError(error: error),
                                ),
                                CustomPaint(painter: _DotGridPainter()),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Responsive.width(5)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: Responsive.height(3)),
                                      _StatusPill(label: content.status, accent: accent),
                                      SizedBox(height: Responsive.height(2.2)),
                                      Text(
                                        content.title,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.headlineSmall?.copyWith(
                                          color: textPrimary,
                                          fontSize: Responsive.font(30),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(height: Responsive.height(1.4)),
                                      Text(
                                        content.description,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                          color: textSecondary,
                                          fontSize: Responsive.font(18),
                                          height: 1.45,
                                        ),
                                      ),
                                      SizedBox(height: Responsive.height(7)),
                                      const Expanded(child: _ScanFrame()),
                                      SizedBox(height: Responsive.height(3)),
                                      Text(
                                        detectedValue == null
                                            ? (isScanning ? 'LENS: SCANNING' : 'LENS: ACTIVE')
                                            : 'QR CODE DETECTED',
                                        style: TextStyle(
                                          color: textSecondary,
                                          fontSize: Responsive.font(15),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      SizedBox(height: Responsive.height(1.2)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          _ToolButton(
                                            icon: isTorchOn ? Icons.flash_on : Icons.flash_off,
                                            label: isTorchOn ? 'TORCH ON' : 'TORCH OFF',
                                            onPressed: onToggleTorch,
                                            accent: accent,
                                          ),
                                          SizedBox(width: width * 0.07),
                                          _ToolButton(
                                            icon: Icons.flip_camera_android_outlined,
                                            label: isRearLens ? 'LENS REAR' : 'LENS FRONT',
                                            onPressed: onSwitchLens,
                                            accent: accent,
                                          ),
                                          SizedBox(width: width * 0.07),
                                          _ToolButton(
                                            icon: Icons.center_focus_strong,
                                            label: 'RE-CENTER',
                                            onPressed: onRecenter,
                                            accent: accent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              Responsive.width(4),
                              Responsive.height(2.5),
                              Responsive.width(4),
                              Responsive.height(3),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute<void>(
                                          builder: (_) => const RoutesScreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.qr_code_scanner_rounded, size: 30),
                                    label: Text(
                                      detectedValue == null
                                        ? (isScanning ? 'Scanning QR Code...' : 'Scan QR Code')
                                        : detectedValue!,
                                      style: TextStyle(
                                        fontSize: Responsive.font(22),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: accent,
                                      foregroundColor: const Color(0xFF00151B),
                                      minimumSize: Size.fromHeight(Responsive.height(9)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Responsive.radius(16)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Responsive.height(2)),
                                SizedBox(height: Responsive.height(2)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _CameraError extends StatelessWidget {
  const _CameraError({required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            error.errorCode == MobileScannerErrorCode.permissionDenied
                ? 'Camera permission is required to scan QR codes.'
                : 'Camera could not be started. Please check camera access.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width(3), vertical: Responsive.height(1)),
      decoration: BoxDecoration(
        color: const Color(0xFF202A36),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 14, height: 14, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
          SizedBox(width: Responsive.width(1.5)),
          Text(label, style: TextStyle(color: const Color(0xFFEAF8FF), fontSize: Responsive.font(16), fontWeight: FontWeight.w700, letterSpacing: 1.2)),
        ],
      ),
    );
  }
}

class _ScanFrame extends StatelessWidget {
  const _ScanFrame();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final frameWidth = size.width.clamp(240.0, 480.0);
        final frameHeight = size.height.clamp(260.0, 460.0);
        return Center(
          child: SizedBox(
            width: frameWidth,
            height: frameHeight,
            child: CustomPaint(painter: _ScanCornerPainter()),
          ),
        );
      },
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({required this.icon, required this.label, required this.onPressed, required this.accent});

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton.filled(
          onPressed: onPressed,
          icon: Icon(icon, size: 28),
          style: IconButton.styleFrom(backgroundColor: const Color(0xFF252C39), foregroundColor: const Color(0xFFE8EFF8), minimumSize: const Size(62, 62)),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(color: accent, fontSize: Responsive.font(10), fontWeight: FontWeight.w700, letterSpacing: 0.7)),
      ],
    );
  }
}

// class _BeaconCard extends StatelessWidget {
//   const _BeaconCard({required this.content, required this.accent, required this.textColor});

//   final ScannerContent content;
//   final Color accent;
//   final Color textColor;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(horizontal: Responsive.width(3.5), vertical: Responsive.height(1.8)),
//       decoration: BoxDecoration(color: const Color(0xFF1B202A), borderRadius: BorderRadius.circular(Responsive.radius(14))),
//       child: Row(
//         children: [
//           Container(width: 18, height: 18, decoration: BoxDecoration(color: accent, shape: BoxShape.circle)),
//           SizedBox(width: Responsive.width(3)),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('SCANNING BEACONS', style: TextStyle(color: const Color(0xFFE8FFF5), fontSize: Responsive.font(14), fontWeight: FontWeight.w800, letterSpacing: 1.1)),
//                 Text(content.deviceName, style: TextStyle(color: const Color(0xFFB7C1CE), fontSize: Responsive.font(16))),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
//             decoration: BoxDecoration(color: const Color(0xFF343B48), borderRadius: BorderRadius.circular(7)),
//             child: Text(content.signalStrength, style: TextStyle(color: textColor, fontSize: Responsive.font(14), fontWeight: FontWeight.w700)),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF00DCE8).withValues(alpha: 0.3);
    for (double x = 20; x < size.width; x += 44) {
      for (double y = 20; y < size.height; y += 44) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScanCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00E5F2)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;
    const length = 52.0;
    final paths = [
      Path()..moveTo(0, length)..lineTo(0, 0)..lineTo(length, 0),
      Path()..moveTo(size.width - length, 0)..lineTo(size.width, 0)..lineTo(size.width, length),
      Path()..moveTo(0, size.height - length)..lineTo(0, size.height)..lineTo(length, size.height),
      Path()..moveTo(size.width - length, size.height)..lineTo(size.width, size.height)..lineTo(size.width, size.height - length),
    ];
    for (final path in paths) {
      canvas.drawPath(path, paint);
    }
    final crossPaint = Paint()
      ..color = const Color(0xFF00E5F2)
      ..strokeWidth = 3;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawLine(center.translate(-22, 0), center.translate(22, 0), crossPaint);
    canvas.drawLine(center.translate(0, -22), center.translate(0, 22), crossPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
