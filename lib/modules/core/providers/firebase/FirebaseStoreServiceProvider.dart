import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dto/BannerDto.dart';
import '../../dto/ChatDto.dart';
import '../../dto/EventDto.dart';
import '../../dto/ItemDto.dart';
import '../../dto/ItemLikedDTO.dart';
import '../../dto/ItemProductImagesDTO.dart';
import '../../dto/ItemReviewDTO.dart';
import '../../dto/UserDto.dart';

/**
 * FirestoreService.dart
 *
 * Firestore Service
 * - Firestore 데이터베이스 서비스
 * - createUser(): User 정보 생성
 * - updateUser(): User 정보 수정
 * - deleteUser(): User 정보 삭제
 * - getUser(): User 정보 불러오기
 * - createEvent(): Event 정보 생성
 * - createItem(): Item 정보 생성
 * - addItemDescriptionImages(): Item Description Images 추가
 * - addItemProductImages(): Item Product Images 추가
 * - addItemReview(): Item Review 추가
 * - updateItem(): Item 정보 수정
 * - deleteItem(): Item 정보 삭제
 * - getItem(): Item 정보 불러오기
 * - fetchItems(): Item List 정보 불러오기
 * - createChat(): Chat 정보 생성
 * - deleteChat(): Chat 정보 삭제
 * - getChat(): Chat 정보 불러오기
 * - createBanner(): Banner 정보 생성
 * - createProfileIamge(): Profile Image 정보 생성
 * - toggleLike(): Firestore에서 사용자의 like 상태를 토글하는 함수
 *
 * @jwson-automation
 */


final firebaseStoreServiceProvider =
    Provider((ref) => FirestoreService(FirebaseFirestore.instance));

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService(this._db);

  // User 정보 생성
  Future<void> createUser(UserDTO user) async {
    try {
      await _db.collection('users').doc(user.userId).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // User 정보 수정
  Future<void> updateUser(String userId, UserDTO user) async {
    try {
      await _db.collection('users').doc(userId).update(user.toMap());
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
  Future<UserDTO?> getUser(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return UserDTO.fromMap(snapshot.data() as Map<String, dynamic>, userId);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  // Event 정보 생성
  Future<void> createEvent(EventDTO event) async {
    try {
      await _db.collection('events').doc(event.itemId).set(event.toMap());
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  // Item 정보 생성
  Future<void> createItem(ItemDTO item) async {
    DocumentReference itemRef = _db.collection('items').doc();
    String docId = itemRef.id;
    item.itemId = docId;
    try {
      itemRef.set(item.toMap());
      await itemRef.set(item.toMap());
      await _db.collection('reviews').doc(docId).set({});
      await _db.collection('salesInfo').doc(docId).set({});
      await _db.collection('descriptionImages').doc(docId).set({});
      await _db
          .collection('likes')
          .doc(docId)
          .set(ItemLikedDTO(itemId: docId).toMap());
      await _db.collection('productImages').doc(docId).set(
          ItemProductImagesDTO(itemId: docId, imageURLs: [item.imageUrl])
              .toMap());
    } catch (e) {
      throw Exception('Failed to create item: $e');
    }
  }

  Future<void> addItemDescriptionImages(String itemId, String imageURL) async {
    try {
      await _db.collection('descriptionImages').doc(itemId).update({
        'imageURLs': FieldValue.arrayUnion([imageURL])
      });
    } catch (e) {
      throw Exception('Failed to add description images: $e');
    }
  }

  Future<void> addItemProductImages(String itemId, String imageURL) async {
    try {
      await _db.collection('productImages').doc(itemId).update({
        'imageURLs': FieldValue.arrayUnion([imageURL])
      });
    } catch (e) {
      throw Exception('Failed to add product images: $e');
    }
  }

  Future<void> addItemReview(String itemId, ItemReviewDTO review) async {
    try {
      await _db.collection('reviews').doc(itemId).update({
        'reviews': FieldValue.arrayUnion([review.toMap()])
      });
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }

  // Item 정보 수정
  Future<void> updateItem(String itemId, ItemDTO item) async {
    try {
      await _db.collection('items').doc(itemId).update(item.toMap());
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  // Item 정보 삭제
  Future<void> deleteItem(String itemId) async {
    try {
      await _db.collection('items').doc(itemId).delete();
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }

  // Item 정보 불러오기
  Future<ItemDTO?> getItem(String itemId) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('items').doc(itemId).get();
      if (snapshot.exists) {
        return ItemDTO.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch item: $e');
    }
  }

  // Item List 정보 불러오기
  Future<List<ItemDTO>> fetchItems() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('items').get();
      return querySnapshot.docs
          .map((doc) => ItemDTO.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch items: $e');
    }
  }

  // Chat 정보 생성
  Future<void> createChat(ChatDTO chat) async {
    try {
      await _db.collection('chats').doc(chat.chatId).set(chat.toMap());
    } catch (e) {
      throw Exception('Failed to create chat: $e');
    }
  }

  // Chat 정보 삭제
  Future<void> deleteChat(String chatId) async {
    try {
      await _db.collection('chats').doc(chatId).delete();
    } catch (e) {
      throw Exception('Failed to delete chat: $e');
    }
  }

  // Chat 정보 불러오기
  Future<ChatDTO?> getChat(String chatId) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('chats').doc(chatId).get();
      if (snapshot.exists) {
        return ChatDTO.fromMap(snapshot.data() as Map<String, dynamic>, chatId);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch chat: $e');
    }
  }

  // Banner 정보 생성
  Future<void> createBanner(BannerDTO banner) async {
    try {
      await _db.collection('banners').doc(banner.itemId).set(banner.toMap());
    } catch (e) {
      throw Exception('Failed to create banner: $e');
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

  // Firestore에서 사용자의 like 상태를 토글하는 함수
  Future<void> toggleLike(String itemID, String userID) async {
    var docRef = FirebaseFirestore.instance.collection('likes').doc(itemID);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      var snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        transaction.set(docRef, {
          'likedUsers': [userID]
        });
      } else {
        List<dynamic> likedUsers = snapshot['likedUsers'];

        if (likedUsers.contains(userID)) {
          transaction.update(docRef, {
            'likedUsers': FieldValue.arrayRemove([userID])
          });
        } else {
          transaction.update(docRef, {
            'likedUsers': FieldValue.arrayUnion([userID])
          });
        }
      }
    });
  }
}
