import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';

class RegisterPage extends StatefulWidget {
  final UserController userController;

  const RegisterPage({Key? key, required this.userController}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _gender = 'Masculino';
  int _age = 0;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome completo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome completo';
                  }
                  if (!value.contains(' ')) {
                    return 'Informe pelo menos um sobrenome';
                  }
                  return null;
                },
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a senha';
                  }
                  if (!_validatePassword(value)) {
                    return 'Senha deve ter 8 caracteres, uma maiúscula e um especial';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                  DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                ],
                onChanged: (value) => setState(() => _gender = value!),
                decoration: const InputDecoration(labelText: 'Gênero'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Informe a idade';
                  }
                  int idade = int.parse(value);
                  if (idade < 10 || idade > 150) {
                    return 'Idade inválida';
                  }
                  return null;
                },
                onSaved: (value) => _age = int.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = widget.userController.register(
        username: _username,
        password: _password,
        gender: _gender,
        age: _age,
      );
      if (success) {
        Navigator.pushReplacementNamed(context, '/statistics');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro no cadastro.')),
        );
      }
    }
  }

  bool _validatePassword(String password) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[!@#\$&*~]).{8,}$');
    return regex.hasMatch(password);
  }
}
