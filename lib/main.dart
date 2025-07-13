import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/pages/main_template_screen.dart';

import 'package:qrgenx/common/provider/history_provider.dart';
import 'package:qrgenx/common/provider/navigation_provider.dart';
import 'package:qrgenx/common/provider/theme_provider.dart';
import 'package:qrgenx/common/theme/theme.dart';
import 'package:qrgenx/data/models/scanned_code_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(ScannedCodeModelAdapter());
  await Hive.openBox<ScannedCodeModel>('scanned_codes');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
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
        home: const MainTemplateScreen(),
      ),
    );
  }
}
