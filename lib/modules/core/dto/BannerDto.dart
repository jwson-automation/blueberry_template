/**
 * BannerDTO
 * - 배너 정보를 담는 DTO 클래스
 * - itemId: 배너 아이템 ID
 * - imageUrl: 배너 이미지 URL
 * - createdAt: 생성된 시간
 * - toMap(): DTO를 Map으로 변환
 * - fromMap(): Map을 DTO로 변환
 *
 * @jwson-automation
 */

class BannerDTO {
  final String itemId;
  final String imageUrl; // 이미지 URL 추가
  final DateTime createdAt = DateTime.now(); // 생성된 시간 필드 추가

  BannerDTO({
    required this.itemId,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl, // 맵에 이미지 URL 추가
      'createdAt': createdAt.toIso8601String(), // 맵에 생성된 시간 추가
    };
  }

  factory BannerDTO.fromMap(Map<String, dynamic> map, String itemId) {
    return BannerDTO(
      itemId: itemId,
      imageUrl: map['imageUrl'], // 맵에서 이미지 URL 추출
    );
  }
}
