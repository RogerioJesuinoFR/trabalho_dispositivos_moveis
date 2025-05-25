import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'views/login_page.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: MaterialApp(
        title: 'IMC+ App',
        theme: ThemeData(primarySwatch: Colors.teal),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/home': (context) => const HomePage(), // Ainda vamos criar
        },
      ),
    );
  }
}
