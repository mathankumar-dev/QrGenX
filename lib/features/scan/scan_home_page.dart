import 'package:flutter/material.dart';
import 'package:qrgenx/common/widgets/button.dart';
import 'package:qrgenx/features/scan/qr_camera_scan_page.dart';
import 'package:qrgenx/features/scan/repository/Scan_Code.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _scanfromimagebutton(context),
                SizedBox(height: screensize.height * 0.03),
                _scanfromcamerabutton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Scan From Image Button
Widget _scanfromimagebutton(BuildContext context) {
  return MyElevatedButton(
    onPressed: () => ScanCode.fromGallery(context),
    text: "Scan From Image",
    icon: Icons.image,
  );
}

//scan from Camera Button
Widget _scanfromcamerabutton(BuildContext context) {
  return MyElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QRScanPage()),
      );
    },
    text: "Scan Using camera",
    icon: Icons.camera_alt,
  );
}
