import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qrgenx/common/widgets/button.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final TextEditingController _controller = TextEditingController();
  String _qrData = '';
  final GlobalKey qrKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateQR() {
    FocusScope.of(context).unfocus();
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _qrData = text;
      });
      _controller.clear();
    }
  }

  Future<void> _shareQrImage() async {
    final permission =
        Platform.isAndroid
            ? await Permission.photos.request()
            : await Permission.storage.request();

    if (!permission.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission denied to access storage")),
      );
      return;
    }

    try {
      final boundary =
          qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_code.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Here is my QR code from QrGenX!');
    } catch (e) {
      debugPrint("Error sharing QR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Enter text or URL",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              MyElevatedButton(
                onPressed: () {
                  if (_controller.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No Data Entered")),
                    );
                  } else {
                    _generateQR();
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text("QR Generated")),
                    // );
                  }
                },
                text: "Generate QR",
                icon: Icons.qr_code,
              ),
              SizedBox(height: screen.height * 0.1),
              _QrArea(context, _qrData, qrKey),
            ],
          ),
        ),
      ),
      floatingActionButton:
          _qrData.isNotEmpty
              ? FloatingActionButton.extended(
                onPressed: _shareQrImage,
                icon: const Icon(Icons.share),
                label: const Text("Share"),
              )
              : null,
    );
  }
}

Widget _QrArea(BuildContext context, String qrdata, GlobalKey key) {
  final screen = MediaQuery.of(context).size;
  return RepaintBoundary(
    key: key,
    child: Container(
      height: screen.height * 0.35,
      width: screen.width * 0.7,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:
          qrdata.isNotEmpty
              ? Center(
                child: QrImageView(
                  data: qrdata,
                  version: QrVersions.auto,
                  size: screen.width * 0.6,
                  backgroundColor: Colors.white,
                  gapless: true,
                ),
              )
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.qr_code, size: 64),
                    SizedBox(height: 12),
                    Text("Enter text to generate a QR code"),
                  ],
                ),
              ),
    ),
  );
}
