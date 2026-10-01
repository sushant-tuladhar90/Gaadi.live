import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/responsive.dart';
import '../../../core/components/floating_loading_button.dart';
import '../controller/device_check_controller.dart';

class DeviceCheckScreen extends StatelessWidget {
  const DeviceCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final controller = Get.put(DeviceCheckController());
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF030F1B) : const Color(0xFFF5F8FC);
    final primaryAccent = isDarkMode ? const Color(0xFF2FE7F5) : const Color(0xFF0EA5E9);
    final textPrimary = isDarkMode ? const Color(0xFFEAF9FF) : const Color(0xFF102033);
    final textSecondary = isDarkMode ? const Color(0xFFB9D9E8) : const Color(0xFF475569);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(4.8),
            vertical: Responsive.height(3),
          ),
          child: Column(
            children: [
              const Spacer(),
              Text(
                'Gaadi Live',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: Responsive.font(34),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: Responsive.height(1)),
              Obx(
                () => Text(
                  controller.errorMessage.value.isNotEmpty
                      ? controller.errorMessage.value
                      : 'Checking this device...',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textSecondary, fontSize: Responsive.font(14)),
                ),
              ),
              const Spacer(),
              Obx(() {
                final hasError = controller.errorMessage.value.isNotEmpty;
                if (!controller.isSlow.value && !hasError) {
                  return const SizedBox.shrink();
                }

                return FloatingLoadingButton(
                  onPressed: controller.checkDevice,
                  isLoading: controller.isChecking.value,
                  icon: Icons.refresh_rounded,
                  label: 'Retry',
                  loadingLabel: 'Checking device...',
                  backgroundColor: primaryAccent,
                  foregroundColor: const Color(0xFF021E2D),
                  minHeight: Responsive.height(8),
                  borderRadius: Responsive.radius(16),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
