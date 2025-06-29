import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/provider/theme_provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _shareApp() {
    final Uri appUri = Uri.parse(
      "https://play.google.com/store/apps/details?id=com.yourapp.id",
    );
    SharePlus.instance.share(ShareParams(uri: appUri));
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
