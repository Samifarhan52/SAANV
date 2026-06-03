import 'dart:async';

import 'package:flutter/material.dart';

import '../app/navigation.dart';
import '../widgets/app_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(buildPageRoute(const LoginScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppBackground(
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = Curves.easeInOut.transform(_controller.value);
            return Transform.translate(
              offset: Offset(0, -12 * value),
              child: Opacity(opacity: 0.86 + value * 0.14, child: child),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [scheme.primary, scheme.tertiary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: scheme.primary.withAlpha((0.34 * 255).round()),
                      blurRadius: 40,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(Icons.favorite_rounded, size: 56, color: Colors.white),
              ),
              const SizedBox(height: 28),
              Text('Velora', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 56)),
              const SizedBox(height: 10),
              Text(
                'Premium dating MVP for modern connections',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}