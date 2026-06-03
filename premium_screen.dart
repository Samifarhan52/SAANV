import 'package:flutter/material.dart';

import '../widgets/app_background.dart';
import '../widgets/glass_card.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Velora Premium')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
          children: [
            Text('Upgrade your visibility', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text(
              'Designed for polished presentation, faster matching, and better quality conversations.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 18),
            GlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Premium boost', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  const _BenefitRow(icon: Icons.rocket_launch_rounded, label: 'Priority placement in discovery'),
                  const _BenefitRow(icon: Icons.auto_awesome_rounded, label: 'See who liked you instantly'),
                  const _BenefitRow(icon: Icons.visibility_rounded, label: 'Read receipts and profile insights'),
                  const _BenefitRow(icon: Icons.support_agent_rounded, label: 'Concierge-level matching tips'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth > 720;
                return Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    _PlanCard(
                      title: 'Monthly',
                      price: '\$19.99',
                      subtitle: 'Perfect for trying premium',
                      highlighted: false,
                      width: wide ? (constraints.maxWidth - 14) / 2 : constraints.maxWidth,
                    ),
                    _PlanCard(
                      title: 'Annual',
                      price: '\$99.99',
                      subtitle: 'Best value, 2 months free',
                      highlighted: true,
                      width: wide ? (constraints.maxWidth - 14) / 2 : constraints.maxWidth,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
              child: const Text('Continue with Premium'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white70))),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.title, required this.price, required this.subtitle, required this.highlighted, required this.width});

  final String title;
  final String price;
  final String subtitle;
  final bool highlighted;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        opacity: highlighted ? 0.16 : 0.08,
        borderOpacity: highlighted ? 0.25 : 0.12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                if (highlighted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha((0.18 * 255).round()),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('Popular', style: TextStyle(fontSize: 12)),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(price, style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 36)),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}