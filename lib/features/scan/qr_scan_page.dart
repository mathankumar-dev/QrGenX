import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrgenx/features/scan/repository/Scan_Code.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final MobileScannerController controller = MobileScannerController();
  bool isScanned = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR")),
      body: SafeArea(
        child: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (capture) {
                if (!isScanned) {
                  ScanCode.onCameraDetect(
                    context,
                    capture,
                    controller,
                    (value) => setState(() => isScanned = value),
                  );
                }
              },
            ),
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
