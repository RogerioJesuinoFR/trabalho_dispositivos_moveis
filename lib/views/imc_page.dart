import 'package:flutter/material.dart';
import 'package:imc_app/services/database_service.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  double? _imc;
  String? _result;

  void _calculateImc() async {
    if (_formKey.currentState!.validate()) {
      final height = double.parse(_heightController.text) / 100;
      final weight = double.parse(_weightController.text);

      final imc = weight / (height * height);
      String result = '';

      if (imc < 18.5) {
        result = 'Abaixo do peso';
      } else if (imc < 24.9) {
        result = 'Peso normal';
      } else if (imc < 29.9) {
        result = 'Sobrepeso';
      } else if (imc < 34.9) {
        result = 'Obesidade Grau I';
      } else if (imc < 39.9) {
        result = 'Obesidade Grau II';
      } else {
        result = 'Obesidade Grau III';
      }

      setState(() {
        _imc = imc;
        _result = result;
      });

      await DatabaseService.saveImcRecord(imc, result);
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    hintText: 'Ex: 170'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua altura';
                  }
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Altura deve ser um número positivo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    hintText: 'Ex: 70'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu peso';
                  }
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Peso deve ser um número positivo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _calculateImc,
                  child: const Text('Calcular IMC')),
              const SizedBox(height: 20),
              if (_imc != null && _result != null) ...[
                Text(
                  'Seu IMC: ${_imc!.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  _result!,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
