import 'package:flutter/material.dart';

import '../widgets/app_background.dart';
import 'chat_list_screen.dart';
import 'discover_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _pages = const [
    HomeScreen(),
    DiscoverScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      bottomPadding: 12,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: KeyedSubtree(key: ValueKey(_index), child: _pages[_index]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (value) => setState(() => _index = value),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Discover'),
                BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_rounded), label: 'Chats'),
                BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}