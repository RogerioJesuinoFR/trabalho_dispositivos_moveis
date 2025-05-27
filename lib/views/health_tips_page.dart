import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HealthTipsPage extends StatefulWidget {
  const HealthTipsPage({super.key});

  @override
  State<HealthTipsPage> createState() => _HealthTipsPageState();
}

class _HealthTipsPageState extends State<HealthTipsPage> {
  List<String> _tips = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTips();
  }

  Future<void> _fetchTips() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulando uma API pública (substituir por uma real se desejar)
      final response = await http.get(
          Uri.parse('https://raw.githubusercontent.com/erickrf/health-tips-api/main/tips.json'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _tips = List<String>.from(data['tips']);
        });
      } else {
        throw Exception('Falha ao carregar dicas');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao carregar dicas')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dicas de Saúde')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tips.isEmpty
              ? const Center(child: Text('Nenhuma dica encontrada'))
              : ListView.builder(
                  itemCount: _tips.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: const Icon(Icons.favorite, color: Colors.red),
                        title: Text(_tips[index]),
                      ),
                    );
                  },
                ),
    );
  }
}
