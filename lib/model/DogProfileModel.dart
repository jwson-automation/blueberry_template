import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/DogProfileModel.freezed.dart';
part 'generated/DogProfileModel.g.dart';

@freezed
class DogProfileModel with _$DogProfileModel {
  const factory DogProfileModel({
    required String name,
    required String gender,
    required String breed,
    required String bio,
    required String imageUrl,
    required String location,
  }) = _DogProfileModel;

  factory DogProfileModel.fromJson(Map<String, dynamic> json) => _$DogProfileModelFromJson(json);
}