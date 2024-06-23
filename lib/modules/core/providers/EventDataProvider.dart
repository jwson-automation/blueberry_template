import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dto/EventDto.dart';

/**
 * EventDataProvider.dart
 *
 * Event Data Provider
 * - 이벤트 이미지 데이터를 제공하는 Provider
 * - fetchEventImages(): 이벤트 이미지 데이터 불러오기
 *
 * @jwson-automation
 */

// 먼저 함수를 선언합니다.
Future<List<EventDTO>> fetchEventImages() async {
  try {
    final eventsCollection = FirebaseFirestore.instance.collection('events');
    final querySnapshot = await eventsCollection.get();

    return querySnapshot.docs
        .map((doc) => EventDTO.fromMap(doc.data(), doc.id))
        .toList();
  } catch (e) {
    print('Failed to fetch event images: $e');
    return []; // 오류 발생 시 빈 리스트 반환
  }
}

// 함수 선언 후에 프로바이더를 선언합니다.
final eventDataProvider = FutureProvider<List<EventDTO>>((ref) async {
  return fetchEventImages();
});