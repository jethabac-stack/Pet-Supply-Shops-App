import 'package:flutter/material.dart';
import '../providers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtl = TextEditingController();
  final _pwCtl = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
  final auth = AuthServiceProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailCtl, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 8),
            TextField(controller: _pwCtl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 16),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() => _loading = true);
                      await auth.login(email: _emailCtl.text, password: _pwCtl.text);
                      if (!mounted) return;
                      setState(() => _loading = false);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, '/catalog');
                    },
                    child: const Text('Log in')),
            const SizedBox(height: 8),
            TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/admin'),
                child: const Text('Log in as Shop Admin')),
          ],
        ),
      ),
    );
  }
}
