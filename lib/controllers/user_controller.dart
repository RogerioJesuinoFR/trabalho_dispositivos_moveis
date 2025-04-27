import '../models/user.dart';

class UserController {
  User? _user;

  User? get user => _user;

  bool register({
    required String username,
    required String password,
    required String gender,
    required int age,
  }) {
    if (username.isEmpty || password.isEmpty) return false;
    _user = User(username: username, password: password, gender: gender, age: age);
    return true;
  }

  bool login(String username, String password) {
    if (_user == null) return false;
    return _user!.username == username && _user!.password == password;
  }

  void updateUserData(double height, double weight, double bodyFat) {
    if (_user != null) {
      _user!.height = height;
      _user!.weight = weight;
      _user!.bodyFat = bodyFat;
    }
  }
}
