import 'package:flutter/material.dart';

import 'ChatListWidget.dart';
import 'LessonChatSendWidget.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ChatListWidget(),
          LessonChatSendWidget(),
        ],
      )

      ,
    );
  }
}
