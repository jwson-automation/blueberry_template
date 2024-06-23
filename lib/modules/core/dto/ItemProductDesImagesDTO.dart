/**
 * ItemProductDesImagesDTO.dart
 *
 * 아이템 상세 이미지 정보를 담는 DTO
 * itemId: 아이템의 고유 ID
 * imageURLs: 해당 아이템의 상세 이미지 URL 목록
 * toMap(): DTO를 Map으로 변환
 * fromMap(): Map을 DTO로 변환
 *
 * @jwson-automation
 */

class ItemProductDesImagesDTO {
  final String itemId; // 아이템의 고유 ID
  final List<String> imageURLs; // 해당 아이템을 좋아하는 사용자들의 UUID 목록

  ItemProductDesImagesDTO({
    required this.itemId,
    List<String>? imageURLs,
  }) : imageURLs = imageURLs ?? [];

  // Firestore에서 데이터를 읽을 때 사용할 생성자
  factory ItemProductDesImagesDTO.fromMap(Map<String, dynamic> map) {
    return ItemProductDesImagesDTO(
      itemId: map['itemId'],
      imageURLs: List<String>.from(map['imageURLs']),
    );
  }

  // Firestore에 데이터를 저장할 때 사용할 메서드
  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'imageURLs': imageURLs,
    };
  }
}
