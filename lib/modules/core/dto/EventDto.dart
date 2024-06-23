import 'CouponDTO.dart';
import 'ItemDto.dart';

/**
 * EventDTO.dart
 *
 * 이벤트 정보를 담는 DTO
 *
 * @jwson-automation
 */

class EventDTO {
  final String itemId;
  final String title;
  final String eventMainTitle;
  final String eventSubTitle;
  final num price; // `num` 타입으로 변경하여 int와 double 모두 처리
  final String description;
  final String imageUrl; // 이미지 URL 추가
  final DateTime createdAt = DateTime.now(); // 생성된 시간 필드 추가
  final String eventItemTitle;
  final String eventItemSubTitle;
  final List<CouponDTO> couponList;
  final List<ItemDTO> eventItemList;

  EventDTO({
    required this.itemId,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.eventMainTitle,
    required this.eventSubTitle,
    required this.eventItemList,
    required this.eventItemTitle,
    required this.eventItemSubTitle,
    this.couponList = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'imageUrl': imageUrl, // 맵에 이미지 URL 추가
      'createdAt': createdAt.toIso8601String(), // 맵에 생성된 시간 추가
      'eventMainTitle': eventMainTitle,
      'eventSubTitle': eventSubTitle,
      'eventItemList': eventItemList.map((item) => item.toMap()).toList(),
      'eventItemTitle': eventItemTitle,
      'eventItemSubTitle': eventItemSubTitle,
      'couponList': couponList.map((coupon) => coupon.toMap()).toList(),
    };
  }

  factory EventDTO.fromMap(Map<String, dynamic> map, String itemId) {
    return EventDTO(
      itemId: itemId,
      title: map['title'],
      price: map['price'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      // 맵에서 이미지 URL 추출
      eventMainTitle: map['eventMainTitle'],
      eventSubTitle: map['eventSubTitle'],
      eventItemList: List<ItemDTO>.from(
        map['eventItemList']
            .map((item) => ItemDTO.fromMap(item)),
      ),
      eventItemTitle: map['eventItemTitle'],
      eventItemSubTitle: map['eventItemSubTitle'],
      couponList: List<CouponDTO>.from(
        map['couponList'].map((coupon) => CouponDTO.fromMap(coupon)),
      ),
    );
  }
}
