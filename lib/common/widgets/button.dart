import 'package:flutter/material.dart';
import 'package:qrgenx/common/app_colors.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final double? minWidth;
  final double? minHeight;

  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.minWidth,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? MediaQuery.of(context).size.width * 0.75,
        minHeight: minHeight ?? 100,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 75),
        iconAlignment: IconAlignment.start,
        
        label: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: AppColors.textColor),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.textColor,
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
