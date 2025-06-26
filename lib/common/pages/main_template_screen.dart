import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/provider/navigation_provider.dart';
import 'package:qrgenx/features/generate/3presentation/pages/create_page.dart';
import 'package:qrgenx/features/history/3presentation/history_page.dart';
import 'package:qrgenx/features/scan/3presentation/pages/scan_page.dart';
import 'package:qrgenx/features/setting/3presentation/settings_page.dart';

class MainTemplateScreen extends StatefulWidget {
  const MainTemplateScreen({super.key});

  @override
  State<MainTemplateScreen> createState() => _MainTemplateScreenState();
}

class _MainTemplateScreenState extends State<MainTemplateScreen> {
  late final PageController _pagecontroller;
  void initState() {
    super.initState();
    _pagecontroller = PageController();
  }

  void dispose() {
    _pagecontroller.dispose();
    super.dispose();
  }

  final List<Widget> _pages = const [
    ScanPage(),
    CreatePage(),
    HistoryPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // final navProvider = Provider.of<NavigationProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pagecontroller,
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: Consumer<NavigationProvider>(
          builder: (
            BuildContext context,
            NavigationProvider navProvider,
            Widget? child,
          ) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: navProvider.currentindex,
              onTap: (index) {
                final currentPage = _pagecontroller.page?.round() ?? 0;

                if ((index - currentPage).abs() == 1) {
                  // Adjacent page: animate
                  _pagecontroller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Far page: jump instantly
                  _pagecontroller.jumpToPage(index);
                }

                // Always update the provider
                navProvider.changeIndex(index);
              },
              items: [
                _scanItem(),
                _createItem(),
                _historyItem(),
                _settingsItem(),
              ],
            );
          },
        ),
      ),
    );
  }
}

// BottomNavigationBarItem builders
BottomNavigationBarItem _scanItem() {
  return const BottomNavigationBarItem(
    icon: Icon(Icons.qr_code_scanner),
    label: "Scan",
    tooltip: "Scan",
  );
}

BottomNavigationBarItem _createItem() {
  return const BottomNavigationBarItem(
    icon: Icon(Icons.create),
    label: "Create",
    tooltip: "Create",
  );
}

BottomNavigationBarItem _historyItem() {
  return const BottomNavigationBarItem(
    icon: Icon(Icons.history),
    label: "History",
    tooltip: "History",
  );
}

BottomNavigationBarItem _settingsItem() {
  return const BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: "Settings",
    tooltip: "Settings",
  );
}
