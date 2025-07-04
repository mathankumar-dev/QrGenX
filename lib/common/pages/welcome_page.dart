import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrgenx/common/app_colors.dart';
import 'package:qrgenx/common/pages/main_template_screen.dart';
import 'package:qrgenx/common/widgets/container.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => const MainTemplateScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: -screensize.height * 0.12,
              left: screensize.width * 0.4,
              child: RoundContainer(height: screensize.height * 0.45),
            ),
            Positioned(
              bottom: -screensize.height * 0.12,
              left: -screensize.width * 0.4,
              child: RoundContainer(height: screensize.height * 0.45),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _welcometext(context),
                  _totext(context),
                  _titletext(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _welcometext(BuildContext context) {
  final screensize = MediaQuery.of(context).size;
  return Text(
    "WELCOME",
    style: GoogleFonts.poppins(
      color: AppColors.textColor,
      fontSize: screensize.width * 0.15,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _totext(BuildContext context) {
  final screensize = MediaQuery.of(context).size;
  return Text(
    "To",
    style: GoogleFonts.poppins(
      color: AppColors.textColor,
      fontSize: screensize.width * 0.10,
    ),
  );
}

Widget _titletext(BuildContext context) {
  final screensize = MediaQuery.of(context).size;
  return Text(
    "QrGenX",
    style: GoogleFonts.poppins(
      color: AppColors.textColor,
      fontSize: screensize.width * 0.13,
      fontWeight: FontWeight.bold,
    ),
  );
}
