import 'package:flutter/material.dart';

import '../app/navigation.dart';
import '../widgets/app_background.dart';
import '../widgets/glass_card.dart';
import 'home_shell.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController(text: 'Avery Stone');
  final _emailController = TextEditingController(text: 'avery@velora.app');
  final _passwordController = TextEditingController(text: '••••••••');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: GlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create your profile', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Set up your premium dating presence in a few steps.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 28),
                  TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full name')),
                  const SizedBox(height: 16),
                  TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email address')),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: 'Brooklyn, NY',
                    decoration: const InputDecoration(labelText: 'City'),
                    items: const [
                      DropdownMenuItem(value: 'Brooklyn, NY', child: Text('Brooklyn, NY')),
                      DropdownMenuItem(value: 'Manhattan, NY', child: Text('Manhattan, NY')),
                      DropdownMenuItem(value: 'Los Angeles, CA', child: Text('Los Angeles, CA')),
                      DropdownMenuItem(value: 'Austin, TX', child: Text('Austin, TX')),
                    ],
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pushReplacement(buildPageRoute(const HomeShell())),
                    style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    child: const Text('Start exploring'),
                  ),
                  const SizedBox(height: 18),
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Back to login')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}