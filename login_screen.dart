import 'package:flutter/material.dart';

import '../app/navigation.dart';
import '../widgets/app_background.dart';
import '../widgets/glass_card.dart';
import 'home_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'avery@velora.app');
  final _passwordController = TextEditingController(text: '••••••••');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final contentWidth = constraints.maxWidth > 760 ? 520.0 : constraints.maxWidth;
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Welcome back', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Text(
                        'Continue your conversations and discover fresh matches.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 28),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email address'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Password'),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: () {}, child: const Text('Forgot password?')),
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(buildPageRoute(const HomeShell()));
                        },
                        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                        child: const Text('Sign in'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white.withAlpha((0.12 * 255).round()))),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('or'),
                          ),
                          Expanded(child: Divider(color: Colors.white.withAlpha((0.12 * 255).round()))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.mail_outline_rounded),
                        label: const Text('Continue with email magic link'),
                        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('New here? ', style: TextStyle(color: Colors.white70)),
                          TextButton(
                            onPressed: () => Navigator.of(context).push(buildPageRoute(const SignupScreen())),
                            child: const Text('Create account'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}