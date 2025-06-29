import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/app_colors.dart';
import 'package:qrgenx/common/provider/theme_provider.dart';

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
    final isDark = context.watch<ThemeProvider>().isDarktheme;

    // Dynamic neumorphic background and shadows
    final backgroundColor =
        isDark ? const Color(0xFF2E2E2E) : const Color(0xFFEFF1F5);
    final topLeftShadow =
        isDark ? const Color.fromARGB(255, 31, 30, 30) : Colors.white;
    final bottomRightShadow =
        isDark ? const Color(0xFF1E1E1E) : const Color(0xFFd1d9e6);
    final iconColor = isDark ? Colors.white70 : Colors.black87;
    final textColor = isDark ? AppColors.darkTextColor : AppColors.textColor;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: topLeftShadow,
            offset: const Offset(-6, -6),
            blurRadius: 10,
          ),
          BoxShadow(
            color: bottomRightShadow,
            offset: const Offset(6, 6),
            blurRadius: 10,
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: width, minHeight: height),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 80, color: iconColor),
              SizedBox(width: width * 0.04),
              Flexible(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontSize: 20,
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
