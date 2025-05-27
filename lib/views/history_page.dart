import 'package:flutter/material.dart';
import 'package:imc_app/services/database_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map> _records = [];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  void _loadRecords() async {
    final records = await DatabaseService.getImcRecords();
    setState(() {
      _records = records.reversed.toList();
    });
  }

  void _clearHistory() async {
    await DatabaseService.clearImcRecords();
    _loadRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de IMC'),
        actions: [
          IconButton(
              onPressed: _clearHistory, icon: const Icon(Icons.delete))
        ],
      ),
      body: _records.isEmpty
          ? const Center(child: Text('Nenhum registro encontrado.'))
          : ListView.builder(
              itemCount: _records.length,
              itemBuilder: (context, index) {
                final record = _records[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                        'IMC: ${record['imc'].toStringAsFixed(2)} - ${record['result']}'),
                    subtitle: Text('Data: ${record['date']}'),
                  ),
                );
              },
            ),
    );
  }
}
