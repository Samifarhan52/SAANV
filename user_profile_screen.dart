import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../widgets/app_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/profile_avatar.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Profile details')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
          children: [
            GlassCard(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  ProfileAvatar(user: user, size: 132),
                  const SizedBox(height: 18),
                  Text('${user.name}, ${user.age}', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 6),
                  Text('${user.profession} · ${user.location}', style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  Text(user.bio, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, height: 1.45)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatChip(label: '${user.compatibility}% match'),
                      const SizedBox(width: 10),
                      _StatChip(label: user.isOnline ? 'Online now' : 'Offline'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text('Interests', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: user.interests
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
            Text('About ${user.name}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _DetailRow(icon: Icons.verified_rounded, label: 'Verified profile'),
                  _DetailRow(icon: Icons.flight_takeoff_rounded, label: 'Recent trip plans'),
                  _DetailRow(icon: Icons.music_note_rounded, label: 'Live music regular'),
                  _DetailRow(icon: Icons.local_cafe_rounded, label: 'Coffee dates preferred'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha((0.14 * 255).round()),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label});

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