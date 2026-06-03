import 'package:flutter/material.dart';

import '../app/navigation.dart';
import '../data/sample_data.dart';
import '../models/user_profile.dart';
import '../widgets/glass_card.dart';
import '../widgets/profile_avatar.dart';
import 'premium_screen.dart';
import 'user_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topUsers = sampleUsers.take(4).toList(growable: false);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good evening, Avery', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 6),
                  const Text('4 new matches waiting for you', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            GlassCard(
              padding: const EdgeInsets.all(10),
              radius: 20,
              opacity: 0.08,
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        const SizedBox(height: 20),
        GlassCard(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your match score is 93%', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    const Text(
                      'Your profile is performing well. Premium visibility would boost matches tonight.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 14),
                    FilledButton(
                      onPressed: () => Navigator.of(context).push(buildPageRoute(const PremiumScreen())),
                      child: const Text('Go Premium'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Theme.of(context).colorScheme.primary.withAlpha((0.7 * 255).round()), Colors.transparent],
                  ),
                ),
                child: Center(
                  child: Text('93', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 36)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text('Recommended for you', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 720 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topUsers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: crossAxisCount == 1 ? 178 : 188,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemBuilder: (context, index) {
                final user = topUsers[index];
                return _UserCard(
                  user: user,
                  onTap: () => Navigator.of(context).push(buildPageRoute(UserProfileScreen(user: user))),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user, required this.onTap});

  final UserProfile user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          ProfileAvatar(user: user, size: 88),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${user.name}, ${user.age}', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(user.tagline, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: user.interests.take(3).map((interest) => _Chip(label: interest)).toList(growable: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.08 * 255).round()),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withAlpha((0.08 * 255).round())),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
    );
  }
}