import 'package:hive/hive.dart';
import '../models/imc_record.dart';

class ImcService {
  final _box = Hive.box('imc_records');

  Future<void> saveRecord(IMCRecord record) async {
    await _box.add(record.toJson());
  }

  List<IMCRecord> getAllRecords() {
    return _box.values
      .map((json) => IMCRecord.fromJson(Map<String, dynamic>.from(json)))
      .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
}
