import 'package:flutter/material.dart';
import 'controllers/user_controller.dart';
import 'views/login_page.dart';
import 'views/register_page.dart';
import 'views/statistics_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Estatísticas Corporais',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(userController: _userController),
        '/register': (context) => RegisterPage(userController: _userController),
        '/statistics': (context) => StatisticsPage(userController: _userController),
      },
    );
  }
}
