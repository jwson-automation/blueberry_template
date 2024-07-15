import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/PersonModel.freezed.dart';
part 'generated/PersonModel.g.dart';

@freezed
class PersonModel with _$PersonModel {
  const factory PersonModel({
    required String name,
    required int age,
  }) = _PersonModel;

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);
}