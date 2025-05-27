import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

class AuthService {
  static const String userBoxName = 'usersBox';
  final _storage = const FlutterSecureStorage();

  /// Login do usuário
  static Future<bool> login(String email, String password) async {
    final box = await Hive.openBox(userBoxName);
    final user = box.get(email);

    if (user != null && user['password'] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', email);
      return true;
    }
    return false;
  }

  /// Cadastro do usuário
  static Future<bool> register(String email, String password, String name) async {
    final box = await Hive.openBox(userBoxName);
    if (box.get(email) != null) {
      return false; // Usuário já existe
    }
    await box.put(email, {'email': email, 'password': password, 'name': name});
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
    return true;
  }

  /// Logout do usuário
  static Future<void> logout() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('username');
    } else {
      final storage = FlutterSecureStorage();
      await storage.delete(key: 'username');
    }
  }

  /// Verifica se o usuário está logado
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail') != null;
  }

  /// Retorna dados do usuário atual
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');
    if (email != null) {
      final box = await Hive.openBox(userBoxName);
      final user = box.get(email);
      return user != null ? Map<String, dynamic>.from(user) : null;
    }
    return null;
  }

  /// Salva o nome do usuário
  Future<void> saveUsername(String username) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
    } else {
      await _storage.write(key: 'username', value: username);
    }
  }

  /// Obtém o nome do usuário
  Future<String?> getUsername() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('username');
    } else {
      return await _storage.read(key: 'username');
    }
  }
}
