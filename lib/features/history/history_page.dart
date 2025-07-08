import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qrgenx/common/provider/history_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan History"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: "Clear All",
            onPressed: () {
              final provider = context.read<HistoryProvider>();
              if (provider.allScans.isNotEmpty) {
                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: const Text("Clear History?"),
                        content: const Text(
                          "Are you sure you want to clear all scan history?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              provider.clear_history();
                              Navigator.pop(context);
                            },
                            child: const Text("Clear"),
                          ),
                        ],
                      ),
                );
              }
            },
          ),
        ],
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, provider, _) {
          final scans = provider.allScans;

          if (scans.isEmpty) {
            return const Center(child: Text("No scan history yet."));
          }

          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) {
              final scan = scans[index];
              final formattedTime = DateFormat(
                'MMM-dd HH:mm',
              ).format(scan.timestamp);
              return ListTile(
                title: Text(scan.value),

                subtitle: Text('${scan.type} • $formattedTime'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.removeAt(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
