import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/responsive.dart';
import '../../../core/services/background_location_service.dart';
import '../../scanner/controller/scanner_controller.dart';
import '../../scanner/presentation/scanner_screen.dart';

class EmergencyStopPage extends StatefulWidget {
  const EmergencyStopPage({
    super.key,
    this.vehicleId,
    this.vehicleName,
    this.routeId = '',
  });

  final String? vehicleId;
  final String? vehicleName;
  final String routeId;

  @override
  State<EmergencyStopPage> createState() => _EmergencyStopPageState();
}

class _EmergencyStopPageState extends State<EmergencyStopPage> {
  @override
  void initState() {
    super.initState();
    final vehicleId = (widget.vehicleId ?? '').trim();
    final routeId = widget.routeId.trim();

    if (vehicleId.isEmpty || routeId.isEmpty) {
      debugPrint('EmergencyStopPage: cannot start tracking because vehicleId or routeId is empty');
      return;
    }

    // Location heartbeats are already running via the foreground service
    // started from the routes screen; this just confirms/refreshes the
    // active vehicle+route in case they changed.
    BackgroundLocationService.start(vehicleId: vehicleId, routeId: routeId);
  }

  Future<void> _handleStop() async {
    await BackgroundLocationService.stop();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Get.delete<ScannerController>();
    Get.deleteAll();

    if (!mounted) return;
    Get.offAll(() => const ScannerScreen());
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF101820),
                    Color(0xFF070B10),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: Responsive.height(6)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Today's Incentive = Rs.100",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.font(24),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: Responsive.height(1)),
                    Text(
                      "you're active on route",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.72),
                        fontSize: Responsive.font(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: Responsive.width(58),
              height: Responsive.width(58),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF5B5B),
                      Color(0xFFB50F1E),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFF4444),
                      blurRadius: 28,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: _handleStop,
                    child: Center(
                      child: Text(
                        'STOP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.font(26),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
