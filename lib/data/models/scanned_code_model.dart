import 'package:hive/hive.dart';

part 'scanned_code_model.g.dart';

@HiveType(typeId: 0)
class ScannedCodeModel {
  @HiveField(0)
  final String value;

  @HiveField(1)
  final String type; 

  @HiveField(2)
  final DateTime timestamp;

  ScannedCodeModel({
    required this.value,
    required this.type,
    required this.timestamp,
  });
}
