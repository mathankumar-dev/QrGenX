import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/pages/splash_screen.dart';
import 'package:qrgenx/common/pages/welcome_page.dart';
import 'package:qrgenx/common/provider/navigation_provider.dart';
import 'package:qrgenx/common/provider/theme_provider.dart';
import 'package:qrgenx/common/theme/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeData =
        themeProvider.isDarktheme
            ? SoftNeumorphicTheme.dark()
            : SoftNeumorphicTheme.light();

    return AnimatedTheme(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      data: themeData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.isDarktheme ? ThemeMode.dark : ThemeMode.light,
        theme: SoftNeumorphicTheme.light(),
        darkTheme: SoftNeumorphicTheme.dark(),
        home: const WelcomePage(),
      ),
    );
  }
}
