import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ChatScreen.dart
  Future<void> addChatMessage(String message) async {
    try {
      await _firestore.collection('chats').add({
        'message': message,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print('Error adding message: $e');
      throw Exception('Failed to add message');
    }
  }
}
