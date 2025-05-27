import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginViewModel extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _error;
  String? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // simula delay

    // Validação simples (exemplo)
    if (username == 'user' && password == '1234') {
      await _storage.write(key: 'user_token', value: 'token123'); // salva token
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = 'Usuário ou senha incorretos';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.delete(key: 'user_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'user_token');
    return token != null;
  }
}
