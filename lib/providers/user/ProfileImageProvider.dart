import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ProfileImageProvider.dart
///
/// Profile Image Provider
/// - 프로필 이미지 데이터를 제공하는 Provider
/// - profileImageUrlStream(): 프로필 이미지 데이터 불러오기
///
/// @jwson-automation
Stream<String> profileImageUrlStream() {
  final userId = FirebaseAuth
      .instance.currentUser!.uid; // 안전하게 처리를 위해 non-null assertion 사용

  return FirebaseFirestore.instance
      .collection('profileImages')
      .doc(userId)
      .snapshots()
      .map((snapshot) {
    if (snapshot.exists && snapshot.data()!.containsKey('imageUrl')) {
      return snapshot.data()!['imageUrl'] as String; // 이미지 URL 반환
    } else {
      return 'default_image_url'; // 문서 또는 필드가 존재하지 않는 경우 기본 URL 반환
    }
  });
}

// 스트림 프로바이더 선언
final profileImageStreamProvider = StreamProvider<String>((ref) {
  return profileImageUrlStream();
});
