import 'package:flutter/material.dart';

import '../app/navigation.dart';
import '../models/chat_message.dart';
import '../models/user_profile.dart';
import '../widgets/app_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/profile_avatar.dart';
import 'voice_call_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user, required this.thread});

  final UserProfile user;
  final ChatThread thread;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _composer = TextEditingController();

  @override
  void dispose() {
    _composer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      bottomPadding: 8,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              ProfileAvatar(user: widget.user, size: 42),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${widget.user.name}, ${widget.user.age}', style: Theme.of(context).textTheme.titleLarge),
                  Text(widget.user.isOnline ? 'Online now' : 'Last seen recently', style: const TextStyle(fontSize: 12, color: Colors.white54)),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(buildPageRoute(VoiceCallScreen(user: widget.user))),
              icon: const Icon(Icons.call_rounded),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                itemCount: widget.thread.messages.length,
                separatorBuilder: (context, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _MessageBubble(message: widget.thread.messages[index]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                radius: 28,
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline_rounded)),
                    Expanded(
                      child: TextField(
                        controller: _composer,
                        decoration: const InputDecoration(
                          hintText: 'Write a message',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.mic_none_rounded)),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(14)),
                      child: const Icon(Icons.send_rounded, size: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final alignment = message.isMe ? Alignment.centerRight : Alignment.centerLeft;
    final bg = message.isMe ? Theme.of(context).colorScheme.primary : Colors.white.withAlpha((0.08 * 255).round());
    final fg = message.isMe ? Colors.black : Colors.white;
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          radius: 22,
          opacity: message.isMe ? 0.92 : 0.08,
          borderOpacity: 0.1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(message.text, style: TextStyle(color: fg, height: 1.35)),
                  const SizedBox(height: 8),
                  Text(message.timeLabel, style: TextStyle(color: fg.withAlpha((0.7 * 255).round()), fontSize: 11)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}