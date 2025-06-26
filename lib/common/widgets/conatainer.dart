import 'package:flutter/material.dart';
import 'package:qrgenx/common/app_colors.dart';

class RoundContainer extends StatelessWidget {
  final double height;

  const RoundContainer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}
