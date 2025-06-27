import 'package:flutter/material.dart';
import 'package:qrgenx/common/app_colors.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String text;
  final IconData icon;

  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        iconColor: AppColors.textColor,
        foregroundColor: AppColors.textColor,
        fixedSize: Size(width, height),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
    );
  }
}
