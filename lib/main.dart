import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/pages/splash_screen.dart';
import 'package:qrgenx/common/pages/welcome_page.dart';
import 'package:qrgenx/common/provider/navigation_provider.dart';
import 'package:qrgenx/common/theme_data.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      // home: SplashScreen(),
      home: WelcomePage(),
    );
  }
}
