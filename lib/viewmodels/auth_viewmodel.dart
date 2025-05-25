import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/local_storage_service.dart';

class AuthViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  UserModel? _user;
  UserModel? get user => _user;

  String? errorMessage;

  Future<bool> login(String email, String password) async {
    final storedUser = await _storage.getUser(email);
    if (storedUser != null && storedUser.password == password) {
      _user = storedUser;
      errorMessage = null;
      notifyListeners();
      return true;
    } else {
      errorMessage = "Email ou senha inválidos.";
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    final existingUser = await _storage.getUser(email);
    if (existingUser != null) {
      errorMessage = "Usuário já existe.";
      notifyListeners();
      return false;
    }
    final newUser = UserModel(email: email, password: password);
    await _storage.saveUser(newUser);
    _user = newUser;
    errorMessage = null;
    notifyListeners();
    return true;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
