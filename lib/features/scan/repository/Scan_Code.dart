import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/provider/history_provider.dart';
import 'package:qrgenx/common/utils/qr_decoder.dart';
import 'package:qrgenx/features/scan/ScanResultpage.dart';

class ScanCode {
  static Future<void> fromGallery(BuildContext context) async {
    final permissions = await [Permission.photos, Permission.storage].request();
    final isGranted = permissions.values.any((status) => status.isGranted);

    if (!isGranted) {
      if (permissions.values.any((s) => s.isPermanentlyDenied)) {
        _showSnackBar(
          context,
          message: "Permission permanently denied. Open settings.",
          actionLabel: "Settings",
          onPressed: openAppSettings,
        );
      } else {
        _showSnackBar(context, message: "Permission denied to access photos");
      }
      return;
    }

    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop QR Code',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
        IOSUiSettings(title: 'Crop QR Code'),
      ],
    );

    if (croppedFile == null) return;

    final result = await QrDecoder.decodeFromImage(croppedFile.path);
    if (context.mounted && result != null) {
      await _handleResult(context, result, type: "QR Code");
    } else {
      _showSnackBar(context, message: "No QR code or Barcode found.");
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
        setScannedFlag(true);
        await controller.stop();

        final String type =
            barcode.format == BarcodeFormat.qrCode ? "QR Code" : "Barcode";

        await _handleResult(context, rawValue, type: type);
        break;
      }
    }
  }

  static Future<void> _handleResult(
    BuildContext context,
    String result, {
    required String type,
  }) async {
    context.read<HistoryProvider>().addscan(result, type);

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ScanResultPage(result: result)),
    );

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void _showSnackBar(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onPressed,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      action:
          (actionLabel != null && onPressed != null)
              ? SnackBarAction(label: actionLabel, onPressed: onPressed)
              : null,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
