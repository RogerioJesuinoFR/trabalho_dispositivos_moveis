import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLogin = true;

  void _submit(AuthViewModel viewModel) async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;

      final success = isLogin
          ? await viewModel.login(email, password)
          : await viewModel.register(email, password);

      if (success && context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? "Login" : "Cadastro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (auth.errorMessage != null)
                Text(auth.errorMessage!, style: TextStyle(color: Colors.red)),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) =>
                    value!.contains('@') ? null : 'E-mail inválido',
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) =>
                    value!.length >= 6 ? null : 'Mínimo 6 caracteres',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submit(auth),
                child: Text(isLogin ? "Entrar" : "Cadastrar"),
              ),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(isLogin
                    ? "Não tem conta? Cadastre-se"
                    : "Já tem conta? Faça login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
