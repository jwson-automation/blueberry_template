import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dto/ItemReviewDTO.dart';

/**
 * ItemReviewProvider.dart
 *
 * Item Review Provider
 * - 아이템 리뷰 데이터를 제공하는 Provider
 * - fetchReviewInfoStream(): 아이템 리뷰 데이터 불러오기
 *
 * @jwson-automation
 */

Stream<List<ItemReviewDTO>> fetchReviewInfoStream(String itemID) {
  return FirebaseFirestore.instance
      .collection('reviews')
      .doc(itemID)
      .snapshots()
      .map((snapshot) {
    if (snapshot.exists && snapshot.data()!.containsKey('reviews')) {
      return List<ItemReviewDTO>.from(
          snapshot.data()!['reviews'].map((review) => ItemReviewDTO.fromMap(review)));
    } else {
      return []; // 문서 또는 필드가 없을 경우 기본 URL 제공
    }
  });
}

final reviewInfoProvider =
StreamProvider.family<List<ItemReviewDTO>, String>((ref, String itemID) {
  return fetchReviewInfoStream(itemID);
});
