import 'package:flutter/material.dart';

import '../../utils/AppStrings.dart';
import '../../widgets/chat/ChatListWidget.dart';
import '../../widgets/chat/ChatSendWidget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.lessonChatScreenTitle)),
      body: Center(
        child: Column(
          children: [
            const Expanded(child: ChatListWidget()),
            ChatSendWidget(),
          ],
        ),
      ),
    );
  }
}
