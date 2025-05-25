import 'package:hive/hive.dart';
import '../models/user_model.dart';

class LocalStorageService {
  static const _userBox = 'usersBox';

  Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox(_userBox);
    await box.put(user.email, user.toJson());
  }

  Future<UserModel?> getUser(String email) async {
    final box = await Hive.openBox(_userBox);
    final userJson = box.get(email);
    if (userJson != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userJson));
    }
    return null;
  }
}
