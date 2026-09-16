import 'package:flutter/material.dart';

import '../../../app/responsive.dart';
import '../data/home_content.dart';
import '../../scanner/presentation/scanner_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    required this.content,
    required this.hasStarted,
    required this.onGetStarted,
    super.key,
  });

  final HomeContent content;
  final bool hasStarted;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF030F1B) : const Color(0xFFF5F8FC);
    final panelColor = isDarkMode ? const Color(0xFF091D2B) : Colors.white;
    final primaryAccent = isDarkMode ? const Color(0xFF2FE7F5) : const Color(0xFF0EA5E9);
    final textPrimary = isDarkMode ? const Color(0xFFEAF9FF) : const Color(0xFF102033);
    final textSecondary = isDarkMode ? const Color(0xFFB9D9E8) : const Color(0xFF475569);
    final tagColor = isDarkMode ? const Color(0xFF0E2734) : const Color(0xFFEAF5FF);
    final subtleBorder = isDarkMode ? primaryAccent.withValues(alpha: 0.25) : const Color(0xFFDBEAFE);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width(4.8),
            vertical: Responsive.height(1.6),
          ),
          child: Column(
            children: [
              SizedBox(height: Responsive.height(1.5)),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(height: Responsive.height(30)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Responsive.radius(18)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(content.imageAsset, fit: BoxFit.cover),
                      _OverlayLabel(
                        alignment: Alignment.topLeft,
                        text: content.gpsLocation,
                        isDarkMode: isDarkMode,
                        primaryAccent: primaryAccent,
                      ),
                      _OverlayLabel(
                        alignment: Alignment.topRight,
                        text: content.telemetry,
                        textAlign: TextAlign.right,
                        isDarkMode: isDarkMode,
                        primaryAccent: primaryAccent,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Responsive.height(2.8)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width(4.2),
                  vertical: Responsive.height(2),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Responsive.radius(18)),
                  color: panelColor,
                  border: Border.all(color: subtleBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bolt_outlined, color: primaryAccent, size: Responsive.font(18)),
                        SizedBox(width: Responsive.width(2)),
                        Expanded(
                          child: Text(
                            'REAL-TIME GPS & SENSOR TELEMETRY',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: textSecondary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.9,
                              fontSize: Responsive.font(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.height(2.6)),
                    Text(
                      content.title,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontSize: Responsive.font(34),
                        fontWeight: FontWeight.w800,
                        color: textPrimary,
                        height: 0.98,
                      ),
                    ),
                    SizedBox(height: Responsive.height(2.6)),
                    Text(
                      content.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: textSecondary,
                        height: 1.5,
                        fontSize: Responsive.font(16),
                      ),
                    ),
                    SizedBox(height: Responsive.height(2.6)),
                    Wrap(
                      spacing: Responsive.width(3),
                      runSpacing: Responsive.height(1.5),
                      children: [
                        for (final badge in content.badges)
                          _Badge(
                            badge: badge,
                            backgroundColor: tagColor,
                            borderColor: subtleBorder,
                            iconColor: isDarkMode ? const Color(0xFFF4C95D) : const Color(0xFFB7791F),
                            textColor: textPrimary,
                          ),
                      ],
                    ),
                    SizedBox(height: Responsive.height(3)),
                    _ProgressBar(isDarkMode: isDarkMode, primaryAccent: primaryAccent),
                    SizedBox(height: Responsive.height(3.6)),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          onGetStarted();
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const ScannerScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryAccent,
                          foregroundColor: const Color(0xFF021E2D),
                          padding: EdgeInsets.symmetric(vertical: Responsive.height(2)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Responsive.radius(16)),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Get Started →',
                          style: TextStyle(
                            fontSize: Responsive.font(30),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverlayLabel extends StatelessWidget {
  const _OverlayLabel({
    required this.alignment,
    required this.text,
    required this.isDarkMode,
    required this.primaryAccent,
    this.textAlign = TextAlign.left,
  });

  final Alignment alignment;
  final String text;
  final bool isDarkMode;
  final Color primaryAccent;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.only(
          top: Responsive.height(2.5),
          left: Responsive.width(4.5),
          right: Responsive.width(4.5),
        ),
        padding: EdgeInsets.all(Responsive.width(2)),
        decoration: BoxDecoration(
          color: (isDarkMode ? const Color(0xFF0A1828) : const Color(0xFFF8FAFC)).withValues(alpha: 0.5),
          border: Border.all(color: primaryAccent.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(Responsive.radius(10)),
        ),
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.font(10),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.badge,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });

  final HomeBadge badge;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badge.icon, color: iconColor, size: 18),
          const SizedBox(width: 8),
          Text(
            badge.label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: Responsive.font(12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.isDarkMode, required this.primaryAccent});

  final bool isDarkMode;
  final Color primaryAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Responsive.height(0.9),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF163E52) : const Color(0xFFDDEEFF),
        borderRadius: BorderRadius.circular(Responsive.radius(10)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: Responsive.width(45),
          height: Responsive.height(0.9),
          decoration: BoxDecoration(
            color: primaryAccent,
            borderRadius: BorderRadius.circular(Responsive.radius(10)),
          ),
        ),
      ),
    );
  }
}
