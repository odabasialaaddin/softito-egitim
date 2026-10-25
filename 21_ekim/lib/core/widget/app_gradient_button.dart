import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final IconData? icon;
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const AppGradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.width,
    this.height = 48,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(12);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueGradientStart.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: AppColors.white, size: 20),
                  const SizedBox(width: 8),
                ],
                DefaultTextStyle(
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
