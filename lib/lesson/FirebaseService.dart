import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // LessonChatScreen.dart
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

  // LessonCanvasScreen.dart
  Future<void> addPoint(Offset point) async {
    try {
      await _firestore.collection('points').add({
        'dx': point.dx,
        'dy': point.dy,
        'timestamp': DateTime.now(), // 추가 정보를 위해 timestamp 사용
      });
    } catch (e) {
      print('Error adding point: $e');
      rethrow;
    }
  }

  // LessonCanvasScreen.dart
  Future<void> clearPoints() async {
    try {
      // 현재 'points' 컬렉션의 모든 문서를 삭제
      QuerySnapshot snapshot = await _firestore.collection('points').get();
      List<DocumentReference> references = snapshot.docs.map((doc) => doc.reference).toList();
      references.forEach((ref) async {
        await ref.delete();
      });
    } catch (e) {
      print('Error clearing points: $e');
      rethrow;
    }
  }
}
