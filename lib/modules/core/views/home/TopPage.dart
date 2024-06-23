import 'package:blueberry_flutter_template/modules/core/views/pages/shopping/ShoppingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/admin/AdminPage.dart';
import '../chat/ChatPage.dart';
import '../pages/mypage/MyPage.dart';
import '../pages/shopping/ShoppingPageSample.dart';

/**
 * TopPage.dart
 *
 * Top Page
 * - BottomNavigationBar를 통해 각 페이지로 이동
 *
 * @jwson-automation
 */

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class TopPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('TopPage build');
    final _selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> _pages = [
      ShoppingPage(),
      ChatPage(),
      MyPage(),
      AdminPage()
    ];

    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.blueGrey[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'MyPage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail_rounded),
            label: 'Admin',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) =>
            ref.read(selectedIndexProvider.notifier).state = index,
      ),
    );
  }
}
