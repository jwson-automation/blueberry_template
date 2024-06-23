/**
 * 아이템 좋아요 정보를 저장하는 DTO
 * - Firestore ItemLiked Collection에 저장할 데이터를 담는 DTO 클래스
 * - itemId: 아이템 ID
 * - likedUsers: 해당 아이템을 좋아하는 사용자들의 UUID 목록
 * - toMap(): DTO를 Map으로 변환
 * - fromMap(): Map을 DTO로 변환
 *
 * @jwson-automation
 */

class ItemLikedDTO {
  final String itemId; // 아이템의 고유 ID
  final List<String> likedUsers; // 해당 아이템을 좋아하는 사용자들의 UUID 목록

  ItemLikedDTO({
    required this.itemId,
    List<String>? likedUsers,
  }) : likedUsers = likedUsers ?? [];

  // Firestore에서 데이터를 읽을 때 사용할 생성자
  factory ItemLikedDTO.fromMap(Map<String, dynamic> map) {
    return ItemLikedDTO(
      itemId: map['itemId'],
      likedUsers: List<String>.from(map['likedUsers']),
    );
  }

  // Firestore에 데이터를 저장할 때 사용할 메서드
  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'likedUsers': likedUsers,
    };
  }
}
