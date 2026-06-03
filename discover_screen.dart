import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/user_profile.dart';
import '../widgets/glass_card.dart';
import '../widgets/profile_avatar.dart';
import 'user_profile_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late final PageController _controller = PageController(viewportFraction: 0.9);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Discover', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 6),
                const Text('Swipe through highly compatible matches', style: TextStyle(color: Colors.white70)),
              ],
            ),
            GlassCard(
              radius: 20,
              padding: const EdgeInsets.all(10),
              opacity: 0.08,
              child: const Icon(Icons.tune_rounded),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 560,
          child: PageView.builder(
            controller: _controller,
            itemCount: sampleUsers.length,
            itemBuilder: (context, index) {
              final user = sampleUsers[index];
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double value = 1.0;
                  if (_controller.position.hasContentDimensions) {
                    value = (_controller.page ?? _controller.initialPage.toDouble()) - index;
                    value = (1 - (value.abs() * 0.18)).clamp(0.82, 1.0);
                  }
                  return Center(child: Transform.scale(scale: value, child: child));
                },
                child: _SwipeCard(user: user),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SwipeCard extends StatelessWidget {
  const _SwipeCard({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => UserProfileScreen(user: user)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [user.accentColor.withAlpha((0.92 * 255).round()), const Color(0xFF11131A)],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: GlassCard(
                        radius: 18,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        opacity: 0.14,
                        borderOpacity: 0.18,
                        child: Text('${user.compatibility}% match', style: const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: ProfileAvatar(user: user, size: 220, showOnlineBadge: false),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      child: GlassCard(
                        radius: 24,
                        opacity: 0.12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${user.name}, ${user.age}', style: Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(height: 6),
                            Text('${user.profession} · ${user.location}', style: const TextStyle(color: Colors.white70)),
                            const SizedBox(height: 10),
                            Text(user.bio, style: const TextStyle(color: Colors.white70, height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: user.interests
                .map(
                  (interest) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.07 * 255).round()),
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
              Expanded(child: _ActionButton(icon: Icons.close_rounded, label: 'Pass', onTap: () {})),
              const SizedBox(width: 12),
              Expanded(child: _ActionButton(icon: Icons.favorite_rounded, label: 'Like', onTap: () {})),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
    );
  }
}