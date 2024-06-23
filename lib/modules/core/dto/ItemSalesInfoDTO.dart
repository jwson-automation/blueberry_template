/**
 * ItemSalesInfoDTO
 * - 아이템의 판매 정보를 저장하는 DTO
 * - Firestore ItemSalesInfo Collection에 저장할 데이터를 담는 DTO 클래스
 * - itemId: 아이템의 고유 ID
 * - purchasedUsers: 해당 아이템을 좋아하는 사용자들의 UUID 목록
 * - orderInfo: 해당 아이템을 구매한 사용자들의 UUID 목록
 * - toMap(): DTO를 Map으로 변환
 * - fromMap(): Map을 DTO로 변환
 *
 *  @jwson-automation
 */

class ItemSalesInfoDTO {
  final String itemId; // 아이템의 고유 ID
  final List<String> purchasedUsers; // 해당 아이템을 좋아하는 사용자들의 UUID 목록
  final List<String> orderInfo; // 해당 아이템을 구매한 사용자들의 UUID 목록

  ItemSalesInfoDTO({
    required this.itemId,
    List<String>? purchasedUsers,
    List<String>? orderInfo,
  })  : orderInfo = orderInfo ?? [],
        purchasedUsers = purchasedUsers ?? [];

  // Firestore에서 데이터를 읽을 때 사용할 생성자
  factory ItemSalesInfoDTO.fromMap(Map<String, dynamic> map) {
    return ItemSalesInfoDTO(
      itemId: map['itemId'],
      purchasedUsers: List<String>.from(map['purchasedUsers']),
      orderInfo: List<String>.from(map['orderInfo']),
    );
  }

  // Firestore에 데이터를 저장할 때 사용할 메서드
  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'purchasedUsers': purchasedUsers,
      'orderInfo': orderInfo,
    };
  }
}
