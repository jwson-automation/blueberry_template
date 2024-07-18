import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/UserModel.dart';

final firebaseStoreServiceProvider =
    Provider((ref) => FirestoreService(FirebaseFirestore.instance));

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService(this._db);

  // User 정보 생성
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.userId).set(user.toJson());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // User 정보 수정
  Future<void> updateUser(String userId, UserModel user) async {
    try {
      await _db.collection('users').doc(userId).update(user.toJson());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // User 정보 삭제
  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  // User 정보 불러오기
  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  Future<void> createProfileIamge(String userId, String imageUrl) async {
    try {
      await _db
          .collection('profileImages')
          .doc(userId)
          .set({'imageUrl': imageUrl});
    } catch (e) {
      throw Exception('Failed to create profile image: $e');
    }
  }
}
