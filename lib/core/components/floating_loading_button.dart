import 'package:flutter/material.dart';

class FloatingLoadingButton extends StatelessWidget {
  const FloatingLoadingButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.loadingLabel,
    this.backgroundColor,
    this.foregroundColor,
    this.minHeight = 56,
    this.borderRadius = 18,
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool isLoading;
  final String? loadingLabel;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double minHeight;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.primaryColor;
    final fgColor = foregroundColor ?? theme.colorScheme.onPrimary;
    final effectiveLabel = isLoading ? (loadingLabel ?? 'Loading...') : label;

    final buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(fgColor),
            ),
          )
        else if (icon != null)
          Icon(icon, size: 24),
        if (isLoading || icon != null) const SizedBox(width: 10),
        Text(
          effectiveLabel,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: fgColor,
          ),
        ),
      ],
    );

    return SizedBox(
      width: double.infinity,
      height: minHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          minimumSize: Size.fromHeight(minHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: buttonContent,
      ),
    );
  }
}
