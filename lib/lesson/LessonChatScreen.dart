import 'package:blueberry_flutter_template/lesson/LessonChatListWidget.dart';
import 'package:flutter/material.dart';

import '../modules/core/utils/AppStrings.dart';
import 'LessonChatSendWidget.dart';

class LessonChatScreen extends StatelessWidget {
  const LessonChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.lessonChatScreenTitle)),
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
