import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * ItemLikedProvider.dart
 *
 * Item Liked Provider
 * - 아이템 좋아요 데이터를 제공하는 Provider
 * - fetchItemLikedStream(): 아이템 좋아요 데이터 불러오기
 *
 * @jwson-automation
 */

Stream<List<String>> fetchProductdesImagesStream(String itemID) {
  return FirebaseFirestore.instance
      .collection('descriptionImages')
      .doc(itemID)
      .snapshots()
      .map((snapshot) {
    if (snapshot.exists && snapshot.data()!.containsKey('imageURLs')) {
      return List<String>.from(snapshot.data()!['imageURLs']);
    } else {
      return []; // 문서 또는 필드가 없을 경우 기본 URL 제공
    }
  });
}

final productdesImagesProvider =
StreamProvider.family<List<String>, String>((ref, String itemID) {
  return fetchProductdesImagesStream(itemID);
});
