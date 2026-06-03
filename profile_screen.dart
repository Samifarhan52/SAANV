import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/profile_avatar.dart';
import 'premium_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      children: [
        Row(
          children: [
            Expanded(child: Text('Profile', style: Theme.of(context).textTheme.headlineMedium)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
          ],
        ),
        const SizedBox(height: 12),
        GlassCard(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              ProfileAvatar(user: currentUser, size: 120),
              const SizedBox(height: 18),
              Text('${currentUser.name}, ${currentUser.age}', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 6),
              Text(currentUser.tagline, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              Text(currentUser.bio, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, height: 1.45)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: currentUser.interests
                    .map(
                      (interest) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.08 * 255).round()),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(interest, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                      ),
                    )
                    .toList(growable: false),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                      child: const Text('Edit profile'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PremiumScreen())),
                      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                      child: const Text('Premium'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text('Account insights', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth > 720;
            const items = [
              _StatItem(label: 'Profile score', value: '93%'),
              _StatItem(label: 'New matches', value: '18'),
              _StatItem(label: 'Profile views', value: '241'),
              _StatItem(label: 'Voice invites', value: '7'),
            ];
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: items
                  .map(
                    (item) => SizedBox(
                      width: wide ? (constraints.maxWidth - 12) / 2 : constraints.maxWidth,
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.label, style: const TextStyle(color: Colors.white54)),
                            const SizedBox(height: 8),
                            Text(item.value, style: Theme.of(context).textTheme.headlineMedium),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            );
          },
        ),
      ],
    );
  }
}

class _StatItem {
  const _StatItem({required this.label, required this.value});

  final String label;
  final String value;
}