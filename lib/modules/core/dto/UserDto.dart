/**
 * UserDTO 클래스는 사용자 정보를 저장하는 데 사용됩니다.
 *
 *  - userId: 사용자의 고유 ID
 *  - name: 사용자의 이름
 *  - email: 사용자의 이메일 주소
 *  - age: 사용자의 나이
 *  - profileImageUrl: 사용자의 프로필 이미지 URL
 *  - createdAt: 사용자 정보가 생성된 시간
 *  - toMap(): DTO를 Map으로 변환
 *  - fromMap(): Map을 DTO로 변환
 *  - copyWith(): DTO를 복사하여 필드를 업데이트
 *
 *  @jwson-automation
 */

class UserDTO {
  final String userId;
  final String name;
  final String email;
  final int age;
  final String profileImageUrl;
  final DateTime createdAt;

  UserDTO({
    required this.userId,
    required this.name,
    required this.email,
    required this.age,
    required this.profileImageUrl,
    DateTime? createdAt,
  }) : this.createdAt =
            createdAt ?? DateTime.now(); // 생성 시간을 옵셔널로 받고, 기본값은 현재 시간

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'profilePicture': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserDTO.fromMap(Map<String, dynamic> map, String userId) {
    if (map['name'] == null || map['email'] == null || map['age'] == null) {
      throw Exception('Missing required fields for UserDTO');
    }
    return UserDTO(
      userId: userId,
      name: map['name'],
      email: map['email'],
      age: map['age'] is int ? map['age'] : int.parse(map['age']),
      profileImageUrl: map['profilePicture'] ?? '',
    );
  }

  // Adding a copyWith method
  UserDTO copyWith({
    String? name,
    String? email,
    int? age,
    String? profilePicture,
  }) {
    return UserDTO(
      userId: this.userId,
      // UserID and createdAt should not change
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      profileImageUrl: profilePicture ?? this.profileImageUrl,
      createdAt: this.createdAt,
    );
  }
}
