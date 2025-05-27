import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'auth_service.dart';

class DatabaseService {
  static const String imcBoxName = 'imcBox';

  static Future<void> saveImcRecord(double imc, String result) async {
    final box = await Hive.openBox(imcBoxName);
    final user = await AuthService.getCurrentUser();

    if (user != null) {
      final date = DateFormat('dd/MM/yyyy – HH:mm').format(DateTime.now());

      final record = {
        'userEmail': user['email'],
        'imc': imc,
        'result': result,
        'date': date,
      };

      await box.add(record);
    }
  }

  static Future<List<Map>> getImcRecords() async {
    final box = await Hive.openBox(imcBoxName);
    final user = await AuthService.getCurrentUser();

    if (user != null) {
      final records = box.values
          .where((r) => r['userEmail'] == user['email'])
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      return records;
    }
    return [];
  }

  static Future<void> clearImcRecords() async {
    final box = await Hive.openBox(imcBoxName);
    await box.clear();
  }
}
