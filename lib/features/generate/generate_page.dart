import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final TextEditingController _controller = TextEditingController();
  String _qrData = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateQR() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _qrData = text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Generate QR")),
      body: Padding(
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
            ElevatedButton.icon(
              onPressed: _generateQR,
              icon: const Icon(Icons.qr_code),
              label: const Text("Generate QR"),
            ),
            const SizedBox(height: 24),
            if (_qrData.isNotEmpty)
              QrImageView(
                data: _qrData,
                version: QrVersions.auto,
                size: screen.width * 0.6,
                backgroundColor: Colors.white,
                gapless: true,
              ),
          ],
        ),
      ),
    );
  }
}
