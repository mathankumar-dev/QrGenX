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
    final double width = minWidth ?? MediaQuery.of(context).size.width * 0.7;
    final double height = minHeight ?? 100;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF1F5), // Soft light background
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.white, // Top-left light
            offset: Offset(-6, -6),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Color(0xFFd1d9e6), // Bottom-right shadow
            offset: Offset(6, 6),
            blurRadius: 10,
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: width, minHeight: height),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0, // Remove default shadow
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 75),
              SizedBox(width: width * 0.025),
              Text(
                text,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
