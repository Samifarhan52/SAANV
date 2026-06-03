import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../widgets/app_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/profile_avatar.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key, required this.user});

  final UserProfile user;

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Voice call'),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline_rounded))],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final scale = 0.96 + (_controller.value * 0.08);
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(colors: [widget.user.accentColor.withAlpha((0.24 * 255).round()), Colors.transparent]),
                          ),
                        ),
                        ProfileAvatar(user: widget.user, size: 140, showOnlineBadge: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(widget.user.name, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 6),
                  const Text('Ringing... 00:42', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 68,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(10, (index) {
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            final barHeight = 18 + ((_controller.value * 1.8 + index * 0.12) % 1.0) * 42;
                            return Container(
                              width: 8,
                              height: barHeight,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: index.isEven
                                    ? widget.user.accentColor.withAlpha((0.82 * 255).round())
                                    : Theme.of(context).colorScheme.secondary.withAlpha((0.82 * 255).round()),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CallAction(icon: Icons.mic_off_rounded, label: 'Mute', active: false, onTap: () {}),
                      _CallAction(icon: Icons.volume_up_rounded, label: 'Speaker', active: true, onTap: () {}),
                      _CallAction(icon: Icons.video_camera_front_rounded, label: 'Video', active: false, onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: FilledButton.styleFrom(backgroundColor: Colors.redAccent, minimumSize: const Size.fromHeight(56)),
                    child: const Text('End Call'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CallAction extends StatelessWidget {
  const _CallAction({required this.icon, required this.label, required this.active, required this.onTap});

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassCard(
          onTap: onTap,
          padding: const EdgeInsets.all(14),
          radius: 22,
          opacity: active ? 0.16 : 0.08,
          child: Icon(icon, color: active ? Theme.of(context).colorScheme.primary : Colors.white70),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}