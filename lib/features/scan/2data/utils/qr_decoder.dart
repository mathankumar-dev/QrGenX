import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:zxing2/qrcode.dart';

class QrDecoder {
  static Future<String?> decodefromimage(String imagePath) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();

    final decodedImage = img.decodeImage(bytes);
    if (decodedImage == null) return null;

    // Convert pixel data to Int32List
    final pixels = decodedImage.convert(numChannels: 4).buffer.asInt32List();

    final luminanceSource = RGBLuminanceSource(
      decodedImage.width,
      decodedImage.height,
      pixels,
    );

    final bitmap = BinaryBitmap(GlobalHistogramBinarizer(luminanceSource));

    try {
      final result = QRCodeReader().decode(bitmap);
      return result.text;
    } catch (_) {
      return null;
    }
  }
}
