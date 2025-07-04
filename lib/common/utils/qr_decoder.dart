import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:zxing2/qrcode.dart';

class QrDecoder {
  static Future<String?> decodeFromImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!file.existsSync()) return null;

      final bytes = await file.readAsBytes();
      final decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) return null;

      final rgbaImage = decodedImage.convert(numChannels: 4);
      final Uint8List pixels = rgbaImage.getBytes();
      final int width = rgbaImage.width;
      final int height = rgbaImage.height;

      // Defensive: avoid index errors
      final int pixelCount = pixels.length ~/ 4;
      final Int32List argbPixels = Int32List(pixelCount);

      for (int i = 0; i < pixelCount; i++) {
        final int r = pixels[i * 4];
        final int g = pixels[i * 4 + 1];
        final int b = pixels[i * 4 + 2];
        final int a = pixels[i * 4 + 3];
        argbPixels[i] = (a << 24) | (r << 16) | (g << 8) | b;
      }

      final luminanceSource = RGBLuminanceSource(width, height, argbPixels);
      // final bitmap = BinaryBitmap(HybridBinarizer(luminanceSource));
      final bitmap = BinaryBitmap(GlobalHistogramBinarizer(luminanceSource));

      final result = QRCodeReader().decode(bitmap);
      return result.text;
    } catch (e) {
      print("QR Decode error: $e");
      return null;
    }
  }
}
