import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/UserModel.freezed.dart';

part 'generated/UserModel.g.dart';

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
