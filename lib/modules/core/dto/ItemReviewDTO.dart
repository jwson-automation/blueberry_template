import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * ItemReviewDTO.dart
 *
 * 아이템 리뷰 정보를 담는 DTO
 * userId: 리뷰 작성자의 UUID
 * content: 리뷰 내용
 * rating: 평점
 * name: 리뷰 작성자의 이름
 * createdAt: 리뷰 작성 시간
 * toMap(): DTO를 Map으로 변환
 * fromMap(): Map을 DTO로 변환
 *
 * @jwson-automation
 */

class ItemReviewDTO {
  final String userId; // 리뷰 작성자의 UUID
  final String content; // 리뷰 내용
  final double rating; // 평점
  final String name; // 리뷰 작성자의 이름
  final DateTime createdAt; // 리뷰 작성 시간

  ItemReviewDTO({
    required this.userId,
    required this.content,
    required this.rating,
    required this.name,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Firestore에서 데이터를 읽을 때 사용할 생성자
  factory ItemReviewDTO.fromMap(Map<String, dynamic> map) {
    return ItemReviewDTO(
      userId: map['userId'],
      content: map['content'],
      rating: map['rating'].toDouble(),
      name: map['name'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Firestore에 데이터를 저장할 때 사용할 메서드
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'rating': rating,
      'name': name,
      'createdAt': createdAt,
    };
  }
}