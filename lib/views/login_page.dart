import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';

class LoginPage extends StatefulWidget {
  final UserController userController;

  const LoginPage({Key? key, required this.userController}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _error = '';
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Usuário'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o usuário' : null,
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
                    return 'Senha inválida';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Cadastrar-se'),
              ),
              if (_error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = widget.userController.login(_username, _password);
      if (success) {
        Navigator.pushReplacementNamed(context, '/statistics');
      } else {
        setState(() {
          _error = 'Usuário ou senha incorretos.';
        });
      }
    }
  }

  bool _validatePassword(String password) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[!@#\$&*~]).{8,}$');
    return regex.hasMatch(password);
  }
}
