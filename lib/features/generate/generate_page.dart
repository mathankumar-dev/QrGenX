import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrgenx/common/widgets/button.dart';

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
      _controller.clear();
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
                      SnackBar(
                        content: Text("No Data Entered"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    _generateQR();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Qr Generated"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                text: "Generate QR",
                icon: Icons.qr_code,
              ),
              SizedBox(height: screen.height * 0.124),
              _QrArea(context, _qrData),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _QrArea(BuildContext context, String qrdata) {
  final screen = MediaQuery.of(context).size;
  return Container(
    height: screen.height * 0.35,
    width: screen.width * 0.7,
    // color: Colors.amber,
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
                children: [
                  Icon(Icons.qr_code, size: 64),
                  SizedBox(height: 12),
                  Text(
                    "Enter text to generate a QR code",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
  );
}
