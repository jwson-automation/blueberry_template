/**
 * ItemDTO
 * 상품 정보를 담는 DTO
 * - title: 상품 제목
 * - originalPrice: 원래 가격
 * - discountedPrice: 할인 가격
 * - description: 상품 설명
 * - imageUrl: 상품 이미지 URL
 * - category: 상품 카테고리
 * - isMainListView: 메인 화면 리스트 뷰 노출 여부
 * - isMainGridView: 메인 화면 그리드 뷰 노출 여부
 */

class ItemDTO {
  // 필요한 필드
  final String title;
  final num originalPrice;
  final num discountedPrice;
  final String description;
  final String imageUrl;
  final String category;
  final bool isMainListView; // 메인 화면 리스트 뷰 노출 여부
  final bool isMainGridView; // 메인 화면 그리드 뷰 노출 여부
  final String productTitle; // 상품명
  final String productDescription; // 상품 설명

  // 생성 후 추가될 필드
  final num viewCount; // 조회수

  // 자동 생성 필드
  String itemId;
  final DateTime createdAt;

  ItemDTO({
    required this.itemId,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.isMainListView,
    required this.isMainGridView,
    required this.productTitle,
    required this.productDescription,
    DateTime? createdAt,
    num? viewCount,
    List<String>? isSell,
    List<String>? totalSell,
    List<String>? isLiked,
    List<ItemDTO>? recommendedItems,
    List<String>? productImages,
  })  : createdAt = createdAt ?? DateTime.now(),
        viewCount = viewCount ?? 0;

  // 저장할 때 사용
  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'title': title,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'isMainListView': isMainListView,
      'isMainGridView': isMainGridView,
      'productTitle': productTitle,
      'productDescription': productDescription,
    };
  }

  // 불러올 때 사용
  factory ItemDTO.fromMap(Map<String, dynamic> map) {
    return ItemDTO(
      itemId: map['itemId'],
      title: map['title'],
      originalPrice: map['originalPrice'],
      discountedPrice: map['discountedPrice'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      category: map['category'],
      isMainListView: map['isMainListView'],
      isMainGridView: map['isMainGridView'],
      productTitle: map['productTitle'],
      productDescription: map['productDescription'],
      createdAt: DateTime.parse(map['createdAt']),
      viewCount: map['viewCount'] as num?,
    );
  }
}
