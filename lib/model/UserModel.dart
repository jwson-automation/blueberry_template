import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/UserModel.freezed.dart';
part 'generated/UserModel.g.dart';

/**
 * UserModel
 *
 * 유저의 정보를 담는 모델입니다.
 *
 * userId: 유저의 아이디
 * name: 유저의 이름
 * email: 유저의 이메일
 * age: 유저의 나이
 * profileImageUrl: 유저의 프로필 이미지 URL
 * createdAt: 유저 정보가 생성된 시간
 *
 * @jwson-automation
 */

@freezed
abstract class UserModel with _$UserModel {
  factory UserModel({
    required String userId,
    required String name,
    required String email,
    required int age,
    required String profileImageUrl,
    required DateTime createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  String get userId;
  String get name;
  String get email;
  int get age;
  String get profileImageUrl;
  DateTime get createdAt;

  Map<String, dynamic> toJson();
}
