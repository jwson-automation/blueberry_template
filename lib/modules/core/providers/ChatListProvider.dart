import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../dto/ChatDto.dart';

/**
 * ChatListProvider.dart
 *
 * Chat List Provider
 * - 채팅 리스트를 관리하는 StateProvider
 * - ChatStateNotifier: 채팅 리스트를 관리하는 StateNotifier
 *
 * @jwson-automation
 */

final categoryProvider = StateProvider<String>((ref) => 'All');

final chatListProvider =
    StateNotifierProvider<ChatStateNotifier, List<ChatDTO>>((ref) {
  return ChatStateNotifier(ref.watch(categoryProvider));
});

class ChatStateNotifier extends StateNotifier<List<ChatDTO>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final Stream<List<ChatDTO>> _messagesStream;

  ChatStateNotifier(String category) : super([]) {
    _messagesStream = _firestore
        .collection('messages')
        .doc(category)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots() // get이라면 그냥 snapshot은 소켓
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatDTO.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
    _messagesStream.listen((messages) {
      state = messages;
    });
  }

  void addMessage(ChatDTO message, String _categoty) {
    print('Adding message: ${message.message}');
    _firestore
        .collection('messages')
        .doc(_categoty)
        .collection('messages')
        .add(message.toMap());
  }
}
