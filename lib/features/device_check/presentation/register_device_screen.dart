import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../app/responsive.dart';
import '../../../app/routes.dart';
import '../model/device_validity_model.dart';

class RegisterDeviceScreen extends StatelessWidget {
  const RegisterDeviceScreen({required this.appInfo, super.key});

  final DriverAppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF030F1B) : const Color(0xFFF5F8FC);
    final textPrimary = isDarkMode ? const Color(0xFFEAF9FF) : const Color(0xFF102033);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Register Driver App',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: Responsive.font(24),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: Responsive.height(3)),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.scanner),
                child: Container(
                  padding: EdgeInsets.all(Responsive.width(4)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Responsive.radius(18)),
                  ),
                  child: QrImageView(
                    data: appInfo.toQrData(),
                    size: Responsive.width(62),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
