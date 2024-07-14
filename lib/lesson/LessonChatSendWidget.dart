import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'FirebaseService.dart';

class LessonChatSendWidget extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _sendChatMessage(String value) async {
      await FirebaseService().addChatMessage(value);
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
              onSubmitted: (value) async {
                value.isEmpty
                    ? null
                    : _sendChatMessage(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              _controller.text.isEmpty
                  ? null
                  : _sendChatMessage(_controller.text);
            },
          ),
        ],
      ),
    );
  }
}
