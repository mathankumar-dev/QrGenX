import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrgenx/common/app_colors.dart';
import 'package:qrgenx/common/pages/main_template_screen.dart';
import 'package:qrgenx/common/widgets/conatainer.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            Positioned(top: -90, left: 150, child: RoundContainer(height: 400)),
            Positioned(
              bottom: -90,
              left: -150,
              child: RoundContainer(height: 400),
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
  return Text(
    "WELCOME",
    style: GoogleFonts.poppins(
      color: AppColors.textColor,
      fontSize: 55,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _totext(BuildContext context) {
  return Text(
    "To",
    style: GoogleFonts.poppins(color: AppColors.textColor, fontSize: 35),
  );
}

Widget _titletext(BuildContext context) {
  return Text(
    "QrGenX",
    style: GoogleFonts.poppins(
      color: AppColors.textColor,
      fontSize: 45,
      fontWeight: FontWeight.bold,
    ),
  );
}
