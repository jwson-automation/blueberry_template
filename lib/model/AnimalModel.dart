import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/AnimalModel.freezed.dart';
part 'generated/AnimalModel.g.dart';

@freezed
class AnimalModel with _$AnimalModel {
  const factory AnimalModel({
    required int animalId,
    required int userId,
    required String name,
    String? species,
    String? breed,
    int? age,
    String? gender,
    String? profilePicture,
    String? bio,
  }) = _AnimalModel;

  factory AnimalModel.fromJson(Map<String, dynamic> json) => _$AnimalModelFromJson(json);
}
