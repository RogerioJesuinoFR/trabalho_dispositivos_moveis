class User {
  String username;
  String password;
  double height;
  double weight;
  double bodyFat;
  String gender;
  int age;

  User({
    required this.username,
    required this.password,
    this.height = 0.0,
    this.weight = 0.0,
    this.bodyFat = 0.0,
    this.gender = '',
    this.age = 0,
  });

  double get bmi {
    if (height <= 0) return 0;
    return weight / (height * height);
  }
}
