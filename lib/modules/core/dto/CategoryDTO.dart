/**
 * CategoryDTO
 * 카테고리 정보를 담는 DTO
 * categoryName: 카테고리 이름
 * imageUrl: 카테고리 이미지 URL
 *
 * @jwson-automation
 */

class CategoryDTO {
  final String categoryName;
  final String imageUrl; // 이미지 URL 추가

  CategoryDTO({
    required this.categoryName,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'imageUrl': imageUrl, // 맵에 이미지 URL 추가
    };
  }

  factory CategoryDTO.fromMap(Map<String, dynamic> map, String categoryName) {
    return CategoryDTO(
      categoryName: categoryName,
      imageUrl: map['imageUrl'], // 맵에서 이미지 URL 추출
    );
  }
}
