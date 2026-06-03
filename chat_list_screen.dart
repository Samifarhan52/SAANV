import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/profile_avatar.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      children: [
        Text('Messages', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 6),
        const Text('Recent conversations and voice invites', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 18),
        TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search conversations',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 16),
        ...chatThreads.map((thread) {
          final user = userById(thread.userId);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassCard(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ChatScreen(user: user, thread: thread)),
              ),
              child: Row(
                children: [
                  ProfileAvatar(user: user, size: 68),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text('${user.name}, ${user.age}', style: Theme.of(context).textTheme.titleLarge)),
                            Text(thread.timeLabel, style: const TextStyle(color: Colors.white54)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(thread.lastMessage, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                  if (thread.unreadCount > 0) ...[
                    const SizedBox(width: 10),
                    Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: Color(0xFFFF8A72), shape: BoxShape.circle),
                      child: Text('${thread.unreadCount}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}