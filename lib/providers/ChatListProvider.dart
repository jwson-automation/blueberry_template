import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatListProvider = StreamProvider<List<String>>((ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore.collection('chats').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => doc['message'] as String).toList();
  });
});
