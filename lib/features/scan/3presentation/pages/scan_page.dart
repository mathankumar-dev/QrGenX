import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrgenx/common/app_colors.dart';
import 'package:qrgenx/common/widgets/button.dart';
import 'package:qrgenx/features/scan/2data/utils/qr_decoder.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyElevatedButton(
              onPressed: () => scancodefromgallery(context),
              width: screensize.width * 0.55,
              height: screensize.height * 0.065,
              text: "Scan From Image",
              icon: Icons.image,
            ),
            SizedBox(height: screensize.height * 0.03),
            MyElevatedButton(
              onPressed: () {},
              width: screensize.width * 0.55,
              height: screensize.height * 0.065,
              text: "Scan Using camera",
              icon: Icons.camera_alt,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> scancodefromgallery(BuildContext context) async {
  // Request both for compatibility
  final permissions = await [Permission.photos, Permission.storage].request();

  // Check if at least one is granted
  final isGranted = permissions.values.any((status) => status.isGranted);

  if (!isGranted) {
    // Handle permanently denied
    if (permissions.values.any((s) => s.isPermanentlyDenied)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Permission permanently denied. Open settings.",
            ),
            action: SnackBarAction(
              label: "Settings",
              onPressed: openAppSettings,
            ),
          ),
        );
      }
    } else {
      // Regular denied
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permission denied to access photos")),
        );
      }
    }
    return;
  }

  // ✅ Permission granted → Pick image
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final result = await QrDecoder.decodefromimage(image.path);
    if (context.mounted && result != null) {
      await handleResult(context, result);
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No QR code or Barcode found.")),
      );
    }
  }
}

Future<void> handleResult(BuildContext context, String result) async {
  final Uri? uri = Uri.tryParse(result);

  if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("QR Code Link"),
            content: Text(result),
            actions: [
              TextButton(
                onPressed: () async {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Could not launch URL")),
                    );
                  }
                },
                child: const Text("Open Link"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
    );
  } else {
    // Not a URL
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Scanned Result"),
            content: Text(result),
          ),
    );
  }
}
