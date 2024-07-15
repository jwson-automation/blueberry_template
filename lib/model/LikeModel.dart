import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/LikeModel.freezed.dart';
part 'generated/LikeModel.g.dart';

@freezed
class LikeModel with _$LikeModel {
  const factory LikeModel({
    required int likeId,
    required int userId,
    required int postId,
    required DateTime createdAt,
  }) = _LikeModel;

  factory LikeModel.fromJson(Map<String, dynamic> json) => _$LikeModelFromJson(json);
}
