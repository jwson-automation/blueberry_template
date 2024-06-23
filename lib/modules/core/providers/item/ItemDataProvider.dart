import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dto/ItemDto.dart';

/**
 * ItemDataProvider.dart
 *
 * Item Data Provider
 * - 아이템 데이터를 제공하는 Provider
 * - fetchItems(): 아이템 데이터 불러오기
 *
 * @jwson-automation
 */

// 먼저 아이템 데이터를 불러오는 함수를 정의합니다.
Future<List<ItemDTO>> fetchItems() async {
  try {
    final itemsCollection = FirebaseFirestore.instance.collection('items');
    final querySnapshot =
        await itemsCollection.orderBy('createdAt', descending: false).get();
    return querySnapshot.docs
        .map((doc) => ItemDTO.fromMap(doc.data()))
        .toList();
  } catch (e) {
    print('Failed to fetch item data: $e');
    return []; // 오류 발생 시 빈 리스트 반환
  }
}

// 이 함수를 이용하는 FutureProvider를 생성합니다.
final itemDataProvider = FutureProvider<List<ItemDTO>>((ref) async {
  return fetchItems();
});
