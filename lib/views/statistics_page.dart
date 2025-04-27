import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';

class StatisticsPage extends StatefulWidget {
  final UserController userController;

  const StatisticsPage({Key? key, required this.userController}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final _formKey = GlobalKey<FormState>();
  late double _height;
  late double _weight;
  late double _bodyFat;

  @override
  void initState() {
    super.initState();
    _height = widget.userController.user?.height ?? 0.0;
    _weight = widget.userController.user?.weight ?? 0.0;
    _bodyFat = widget.userController.user?.bodyFat ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    User? user = widget.userController.user;
    if (user == null) {
      return const Center(child: Text('Usuário não encontrado.'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Estatísticas Corporais')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Usuário: ${user.username}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Altura (m)'),
                initialValue: _height > 0 ? _height.toString() : '',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || double.tryParse(value) == null ? 'Informe a altura' : null,
                onSaved: (value) => _height = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                initialValue: _weight > 0 ? _weight.toString() : '',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || double.tryParse(value) == null ? 'Informe o peso' : null,
                onSaved: (value) => _weight = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Percentual de gordura (%)'),
                initialValue: _bodyFat > 0 ? _bodyFat.toString() : '',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || double.tryParse(value) == null ? 'Informe o percentual de gordura' : null,
                onSaved: (value) => _bodyFat = double.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Salvar'),
              ),
              const SizedBox(height: 20),
              Text('IMC: ${user.bmi.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.userController.updateUserData(_height, _weight, _bodyFat);
      setState(() {}); // Atualiza a tela
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados atualizados com sucesso!')),
      );
    }
  }
}
