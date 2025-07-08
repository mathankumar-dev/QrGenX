import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanResultPage extends StatelessWidget {
  final String result;

  const ScanResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(result);

    return Scaffold(
      appBar: AppBar(title: const Text("Scan Result")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Result:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            SelectableText(result, style: TextStyle(fontSize: 16)),

            const SizedBox(height: 24),
            if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https'))
              ElevatedButton.icon(
                icon: Icon(Icons.open_in_browser),
                label: Text("Open Link"),
                onPressed: () async {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Could not launch URL")),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
