import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/provider/theme_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _shareApp() async {
    final info = await PackageInfo.fromPlatform();
    final packageName = info.packageName;

    final url = "https://play.google.com/store/apps/details?id=$packageName";

    SharePlus.instance.share(
      ShareParams(text: "Check out QRGenX on Play Store!\n$url"),
    );
  }

  void _openPrivacyPolicy() async {
    final url = Uri.parse('https://sites.google.com/view/mkapps-qrgenx');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      print("Something went wrong: Cannot launch URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return ListTile(
                  leading:
                      themeProvider.isDarktheme
                          ? const Icon(Icons.nights_stay)
                          : const Icon(Icons.sunny),
                  title: const Text("Theme"),
                  trailing: CupertinoSwitch(
                    value: themeProvider.isDarktheme,
                    onChanged: (value) => themeProvider.toggleTheme(),
                  ),
                  onTap: () => themeProvider.toggleTheme(),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text("Privacy Policy"),
              onTap: _openPrivacyPolicy,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Our App"),
              onTap: _shareApp,
            ),
            AboutListTile(
              icon: Icon(Icons.info_outline),
              applicationName: 'QRGenX',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2025 MKAPPS',
              child: Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
