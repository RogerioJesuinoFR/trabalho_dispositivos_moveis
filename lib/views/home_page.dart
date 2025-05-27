import 'package:flutter/material.dart';
import 'package:imc_app/services/auth_service.dart';
import 'package:imc_app/views/health_tips_page.dart';
import 'package:imc_app/views/history_page.dart';
import 'package:imc_app/views/imc_page.dart';
import 'package:imc_app/views/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) async {
    await AuthService.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        actions: [
          IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ImcPage()));
                },
                child: const Text('Calcular IMC')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HistoryPage()));
                },
                child: const Text('Histórico de IMC')),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HealthTipsPage()));
                },
                child: const Text('Dicas de Saúde')),
          ],
        ),
      ),
    );
  }
}
