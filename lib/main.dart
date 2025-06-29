import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/pages/splash_screen.dart';
import 'package:qrgenx/common/pages/welcome_page.dart';
import 'package:qrgenx/common/provider/navigation_provider.dart';
import 'package:qrgenx/common/provider/theme_provider.dart';
import 'package:qrgenx/common/theme/Theme.dart';

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
    final isDark = context.watch<ThemeProvider>().isDarktheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: SoftNeumorphicTheme.light(),
      darkTheme: SoftNeumorphicTheme.dark(),
      // home: SplashScreen(),
      home: WelcomePage(),
    );
  }
}
