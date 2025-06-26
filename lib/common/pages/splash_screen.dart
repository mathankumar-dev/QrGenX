import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrgenx/common/app_colors.dart';
import 'package:qrgenx/common/pages/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => const WelcomePage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: Text(
            "QRGENX",
            style: GoogleFonts.poppins(color: AppColors.textColor),
          ),
        ),
      ),
    );
  }
}
