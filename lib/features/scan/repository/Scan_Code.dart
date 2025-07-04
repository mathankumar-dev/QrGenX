import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrgenx/common/utils/qr_decoder.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanCode {
  static Future<void> fromGallery(BuildContext context) async {
    final permissions = await [Permission.photos, Permission.storage].request();
    final isGranted = permissions.values.any((status) => status.isGranted);

    if (!isGranted) {
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
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Permission denied to access photos")),
          );
        }
      }
      return;
    }

    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    print("Picked path: ${image?.path}");

    if (image != null) {
      final result = await QrDecoder.decodeFromImage(image.path);
      if (context.mounted && result != null) {
        await _handleResult(context, result);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No QR code or Barcode found.")),
        );
      }
    }
  }

  static Future<void> onCameraDetect(
    BuildContext context,
    BarcodeCapture capture,
    MobileScannerController controller,
    ValueSetter<bool> setScannedFlag,
  ) async {
    for (final barcode in capture.barcodes) {
      final String? rawValue = barcode.rawValue;
      if (rawValue != null && context.mounted) {
        setScannedFlag(true); // for stateful UI
        await controller.stop();
        await _handleResult(context, rawValue);
        break;
      }
    }
  }

  static Future<void> _handleResult(BuildContext context, String result) async {
    final Uri? uri = Uri.tryParse(result);

    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      await showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("QR Code Link"),
              content: Text(result),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
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
      await showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Scanned Result"),
              content: Text(result),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
      );
    }

    // Close the scanner screen after result
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
