import 'package:blueberry_flutter_template/modules/core/views/match/MatchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../chat/ChatPage.dart';
import '../pages/admin/AdminPage.dart';
import '../pages/mypage/LoginPage.dart';

/// TopPage.dart
///
/// Top Page
/// - BottomNavigationBar를 통해 각 페이지로 이동
///
/// @jwson-automation

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('TopPage build');
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> pages = [
      MatchPage(),
      ChatPage(),
      AdminPage(),
      LoginPage(),
    ];

    return Scaffold(
      body: Center(
        child: pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.blueGrey[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail_rounded),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'MyPage',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) =>
            ref.read(selectedIndexProvider.notifier).state = index,
      ),
    );
  }
}
