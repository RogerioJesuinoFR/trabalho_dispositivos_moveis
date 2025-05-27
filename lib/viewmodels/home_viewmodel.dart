import 'package:flutter/material.dart';
import '../models/imc_record.dart';
import '../services/imc_service.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ImcService _imcService = ImcService();
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();

  List<IMCRecord> _records = [];
  List<IMCRecord> get records => _records;

  String _healthTip = 'Carregando dica de saúde...';
  String get healthTip => _healthTip;

  String? _username;
  String? get username => _username;

  HomeViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    _records = _imcService.getAllRecords();
    _healthTip = await _apiService.fetchHealthTip();
    _username = await _authService.getUsername();
    notifyListeners();
  }

  double calculateImc(double weight, double height) {
    return weight / (height * height);
  }

  Future<void> addRecord(double weight, double height) async {
    final imc = calculateImc(weight, height);
    final record = IMCRecord(
      weight: weight,
      height: height,
      imc: imc,
      date: DateTime.now(),
    );
    await _imcService.saveRecord(record);
    _records.insert(0, record);
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService.logout();
  }
}
