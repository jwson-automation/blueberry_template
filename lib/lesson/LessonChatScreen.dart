import 'package:blueberry_flutter_template/lesson/LessonChatListWidget.dart';
import 'package:flutter/material.dart';

import 'LessonChatSendWidget.dart';

class LessonChatScreen extends StatelessWidget {
  const LessonChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Center(
        child: Column(
          children: [
            Expanded(child: LessonChatListWidget()),
            LessonChatSendWidget(),
          ],
        ),
      ),
    );
  }
}
