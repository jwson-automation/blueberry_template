import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Stream 연결해둔 데이터 타입 <-- 흘러 들어오는 상태
// FutureProvider


final chatListProvider = StreamProvider<List<String>>((ref) {
  final firestore =
      FirebaseFirestore.instance; // 복제 해서 가져온다. 컨트롤 할 수 있는 영역을 복제해온다?

  return firestore.collection('chats').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => doc['message'] as String).toList();
  });
});
