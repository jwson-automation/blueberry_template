import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dto/ChatDto.dart';
import '../../providers/ChatListProvider.dart'; // chatProvider가 정의된 곳을 가정
import '../../providers/user/UserInfoProvider.dart';
import '../../utils/AppStrings.dart';

/// ChatPage.dart
///
/// Chat Page
/// - 채팅 화면
/// - 카테고리별 채팅 메시지를 보여주는 화면
///
/// @jwson-automation

class ChatPage extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ['All', 'Friends', 'Family', 'Work'];
    final selectedCategory = ref.watch(categoryProvider);
    final messages = ref.watch(chatListProvider);
    final nickname = ref.watch(userInfoNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.chatPageTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var category in categoryList)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: selectedCategory == category.toLowerCase(),
                          onSelected: (bool selected) {
                            ref.read(categoryProvider.notifier).state =
                                category.toLowerCase();
                          },
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.grey[300],
                          labelStyle: TextStyle(
                              color: selectedCategory == category.toLowerCase()
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return _buildChatBubble(message, "nickname");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: AppStrings.chatHint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        print('_nickname: ${nickname.name}');
                        ChatDTO newMessage = ChatDTO(
                          chatId: UniqueKey().toString(),
                          // Example, needs proper implementation
                          senderId: nickname.name,
                          // Example, needs authentication context
                          message: _controller.text,
                          timestamp: DateTime
                              .now(), // This should be adjusted if using server timestamps
                        );
                        ref
                            .read(chatListProvider.notifier)
                            .addMessage(newMessage, selectedCategory);
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(ChatDTO message, String nickname) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue[100],
            ),
            child: Text(
              message.message,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 4.0), // 유저 아이디와 날짜 사이의 간격 조절
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User ID: ${message.senderId}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '${message.timestamp}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // 기본 스크롤바를 사용하지 않음
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(); // 드래그 동작을 허용하는 스크롤 물리 특성
  }
}
