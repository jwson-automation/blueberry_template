import 'package:flutter/material.dart';

class FriendsListPage extends StatelessWidget {
  const FriendsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구 목록 페이지'),
      ),
      body: const Center(
        child: Text('This is the Friends List screen'),
      ),
    );
  }
}
