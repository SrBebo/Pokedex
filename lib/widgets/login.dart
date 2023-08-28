import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final email = _emailController.text;
    final password = _passwordController.text;

    await loginProvider.login(email, password);

    if (loginProvider.isLoggedIn) {
      final user =
          email; // Aquí deberías obtener el nombre de usuario desde donde lo tengas almacenado
      print('Inicio de sesión exitoso: $user');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Inicio de sesión exitoso: $user'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio de Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
