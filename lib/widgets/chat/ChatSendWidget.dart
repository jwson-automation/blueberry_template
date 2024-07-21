import 'package:flutter/material.dart';

import '../../services/FirebaseService.dart';

class ChatSendWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatSendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService();

    void sendChatMessage(String value) async {
      await firebaseService.addChatMessage(value);
      _controller.clear();
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  hintText: 'Enter message', border: OutlineInputBorder()),
              onSubmitted: (value) async { // 엔터키가 눌러졌을때 하는 행동
                value.isEmpty
                    ? null
                    : sendChatMessage(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async { // 눌러졌을때 행동
              _controller.text.isEmpty
                  ? null
                  : sendChatMessage(_controller.text);
            },
          ),
        ],
      ),
    );
  }
}
