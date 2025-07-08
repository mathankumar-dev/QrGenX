import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrgenx/data/models/scanned_code_model.dart';

// to enable history feature
class HistoryProvider extends ChangeNotifier {
  final Box<ScannedCodeModel> _box = Hive.box('scanned_codes');

  List<ScannedCodeModel> get allScans => _box.values.toList().reversed.toList();

  // to add code to history
  void addscan(String value, String type) {
    final scan = ScannedCodeModel(
      value: value,
      type: type,
      timestamp: DateTime.now(),
    );
    _box.add(scan);
    notifyListeners();
  }

  // to clear from history
  void clear_history() async {
    await _box.clear(); // ✅ Make sure to await this
    notifyListeners(); // ✅ Notifies UI
  }

  // todelete individual entry
  void removeAt(int index) {
    final key = _box.keyAt(_box.length - 1 - index); // reverse order
    _box.delete(key);
    notifyListeners();
  }
}
