import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dto/ItemSalesInfoDTO.dart';

/**
 * ItemSalesInfoProvider.dart
 *
 * Item Sales Info Provider
 * - 아이템 판매 정보 데이터를 제공하는 Provider
 * - fetchSalesInfoStream(): 아이템 판매 정보 데이터 불러오기
 *
 * @jwson-automation
 */

Stream<List<ItemSalesInfoDTO>> fetchSalesInfoStream(String itemID) {
  return FirebaseFirestore.instance
      .collection('salesInfo')
      .doc(itemID)
      .snapshots()
      .map((snapshot) {
    if (snapshot.exists) {
      return [
        ItemSalesInfoDTO.fromMap(snapshot.data() as Map<String, dynamic>)
      ];
    } else {
      return []; // 문서 또는 필드가 없을 경우 기본 URL 제공
    }
  });
}

final salesInfoProvider =
    StreamProvider.family<List<ItemSalesInfoDTO>, String>((ref, String itemID) {
  return fetchSalesInfoStream(itemID);
});
