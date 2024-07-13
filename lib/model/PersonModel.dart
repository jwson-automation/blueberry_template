import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/PersonModel.freezed.dart';
part 'generated/PersonModel.g.dart';

/**
 * PersonModel
 *
 * 사람의 정보를 담는 모델입니다.
 *
 * name: 사람의 이름
 * age: 사람의 나이
 *
 * @jwson-automation
 */

@freezed
class PersonModel with _$PersonModel {
  const factory PersonModel({
    required String name,
    required int age,
  }) = _PersonModel;

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);
}